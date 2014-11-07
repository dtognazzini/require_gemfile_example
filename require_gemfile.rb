raise "This implementation only works with Bundler 1.3.5" unless Gem::Version::Requirement.create("1.3.5").satisfied_by?(Gem::Version.create(Bundler::VERSION))

require 'bundler/dsl'

$DRT_LOG = false
module RequireGemfile
  def log(*args)
    if $DRT_LOG
      puts *args
    end
  end

  def require_gemfile(gemfile_path)
    gemfile_path = Pathname.new(gemfile_path).expand_path(Bundler.root)
    log "looking for #{gemfile_path}"

    other_file = self.class.new
    Dir.chdir(gemfile_path.dirname) do
      other_file.eval_gemfile(gemfile_path)
    end

    merge(other_file, gemfile_path)
  end

  def source(*args, &block)
    log "source(#{args.inspect})"
    super(*args, &block)
  end

  private
  def merge(other_file, gemfile_path)
    other_file.sources.each do |source|
      if source.is_a?(Bundler::Source::Path)
        log "looking at #{source.path.to_s.inspect}"

        rebased_path = source.path.expand_path(File.dirname(gemfile_path)).relative_path_from(Bundler.root)
        log "Rebased #{source.path.to_s.inspect} to #{rebased_path.to_s.inspect}"
        log "path(#{rebased_path.inspect}, #{source.options.inspect})"
        path(rebased_path, source.options)
      end
    end

    rubygems_source = other_file.instance_variable_get(:@rubygems_source)
    if rubygems_source
      rubygems_source.remotes.each do |remote|
        @rubygems_source.add_remote(remote)
      end
    end
  end

  protected

  attr_reader :sources
end

module Bundler
  class Dsl
    prepend RequireGemfile
  end
end
