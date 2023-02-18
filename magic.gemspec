# frozen_string_literal: true

require_relative 'lib/magic/version'

Gem::Specification.new do |spec|
  spec.name = 'magic'
  spec.version = Magic::VERSION
  spec.authors = ['Carlos Soria']
  spec.email = ['csoria@cultome.io']

  spec.summary = 'Magic The Gathering game engine'
  spec.description = 'Magic The Gathering game engine'
  spec.homepage = 'https://github.com/cultome/magic'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/cultome/magic'
  spec.metadata['changelog_uri'] = 'https://github.com/cultome/magic'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
