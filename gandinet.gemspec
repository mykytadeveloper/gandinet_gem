# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gandinet/version'

Gem::Specification.new do |spec|
  spec.name          = 'gandinet'
  spec.version       = Gandinet::VERSION
  spec.authors       = ['NikitaS']
  spec.email         = ['mykytadeveloper@gmail.com']

  spec.summary       = 'gandy api v5'
  spec.description   = 'gandy api v5 '
  spec.homepage      = 'https://github.com/usiegj00/gandinet.git'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_dependency 'unirest', '~> 1.1.2'
  spec.add_dependency 'oauth2', '~> 1.4.1'
end
