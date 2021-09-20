require_relative 'lib/prom_check/version'

Gem::Specification.new do |spec|
  spec.name          = 'prom_check'
  spec.version       = PromCheck::VERSION
  spec.authors       = ['Jayapriya Pai']
  spec.email         = ['slashpai9@gmail.com']

  spec.summary       = 'Gem to do prometheus analysis'
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/slashpai/prom_check.git'
  spec.license               = 'Apache-2.0'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/slashpai/prom_check.git'
  spec.metadata['changelog_uri'] = 'https://github.com/slashpai/prom_check/blob/main/CHANGELOG.MD'

  spec.files = %w[prom_check.gemspec] + Dir['*.md', 'bin/*', 'lib/**/*.rb']

  spec.bindir        = 'bin'
  spec.executables   = 'prom_check'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'pry', '~> 0.14'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 1.21'

  spec.add_runtime_dependency 'concurrent-ruby', '~> 1.1'
  spec.add_runtime_dependency 'rest-client', '~> 2.1'
  spec.add_runtime_dependency 'terminal-table', '~> 3.0'
  spec.add_runtime_dependency 'thor', '~> 1.1'
end
