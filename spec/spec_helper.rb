$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH << File.join(File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
require 'pry'

require 'file_convert'

RSpec.configure do |config|
  config.mock_with :rspec do |mock_config|
    mock_config.verify_doubled_constant_names = true
    mock_config.verify_partial_doubles = true
    mock_config.syntax = [:expect]
  end
end
