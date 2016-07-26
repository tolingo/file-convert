# frozen_string_literal: true
require 'rubygems'
require 'rake'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
end
RSpec::Core::RakeTask.new(:integration) do |spec|
  spec.pattern = 'spec/integration/**/*_integration.rb'
end
RuboCop::RakeTask.new

task default: [:spec, :rubocop]
task build: [:spec, :integration, :rubocop]
