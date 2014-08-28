require 'lib/file_convert/version'

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
  s.files         = Dir['README.md', 'lib/**/*']
  s.require_path  = 'lib'

  s.required_ruby_version = Gem::Requirement.new '>= 1.9.2'

  s.add_dependency 'google-api-client', '~> 0.7.0'
end
