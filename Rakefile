# require_relative 'config/application'

# Rails.application.load_tasks

require 'rake'
require 'rspec/core/rake_task'
require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = '--format documentation'
end

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = 'features --format pretty'
end

task default: [:spec, :cucumber]
