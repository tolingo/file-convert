$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'file_convert/version'

Gem::Specification.new do |s|
  s.platform      = Gem::Platform::RUBY
  s.name          = 'file-convert'
  s.version       = FileConvert::Version::STRING
  s.summary       = 'Instrumentalize Google Drive to convert files'
  s.description   = 'Uses google-api-ruby-client and Google Drive to convert files from one mime-type to another'

  s.authors       = ['Roman Ernst', 'Jan Raasch']
  s.email         = ['rernst@farbenmeer.net', 'jan@janraasch.com']
  s.license       = 'MIT'
  s.homepage      = 'https://github.com/tolingo/file-convert'
  s.files         = Dir['README.md', 'LICENSE', 'lib/**/*']
  s.require_path  = 'lib'

  s.required_ruby_version = Gem::Requirement.new '>= 1.9.2'

  s.add_dependency 'google-api-client', '~> 0.7.0'

  s.add_development_dependency 'rspec', '~> 3.0.0'
  s.add_development_dependency 'rubocop', '~> 0.25.0'
  s.add_development_dependency 'rake', '~> 10.3.2'
  s.add_development_dependency 'pry', '~> 0.10.1'
end
