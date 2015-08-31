$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'file_convert/version'

Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'file-convert'
  s.version       = FileConvert::Version::STRING
  s.summary       = 'Instrumentalize Google Drive to convert files'
  s.description   = 'Uses google-api-ruby-client and Google Drive to convert files from one mime-type to another'

  s.authors       = ['Roman Ernst', 'Jan Raasch', 'Christoph Hugo']
  s.email         = ['rernst@farbenmeer.net', 'jan@janraasch.com', 'christoph.hugo@gmail.com']
  s.license       = 'MIT'
  s.homepage      = 'https://github.com/tolingo/file-convert'
  s.files         = Dir['README.md', 'LICENSE', 'lib/**/*']
  s.require_path  = 'lib'

  s.required_ruby_version = Gem::Requirement.new '>= 1.9.2'

  s.add_dependency 'google-api-client', '~> 0.8.1'

  s.add_development_dependency 'rspec', '~> 3.3.0'
  s.add_development_dependency 'rubocop', '~> 0.33.0'
  s.add_development_dependency 'rake', '~> 10.4.2'
  s.add_development_dependency 'pry', '~> 0.10.1'
  s.add_development_dependency 'codeclimate-test-reporter', '~> 0.4.0'
end
