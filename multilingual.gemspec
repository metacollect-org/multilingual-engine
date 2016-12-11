$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'multilingual/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'multilingual'
  s.version     = Multilingual::VERSION
  s.authors     = ['metacollect']
  s.email       = ['develop@metacollect.org']
  s.homepage    = 'https://github.com/metacollect-org/'
  s.summary     = 'The multilingual rails engine should be mounted to provide models for international language support of stored content.'
  s.description = 'Please refer to the README.md'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'spec/factories/**/*', 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['spec/**/*']

  s.add_dependency 'rails', '~> 5.0.0', '>= 5.0.0.1'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'rubocop'
  s.add_development_dependency 'rubocop-rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'fuubar'
end
