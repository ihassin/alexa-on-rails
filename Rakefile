require_relative 'config/application'
require 'rspec/core/rake_task'

Rails.application.load_tasks

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  t.rspec_opts = '--format documentation'
end

task default: [:spec]

Rake::Task['test'].clear
Rake::Task['cucumber'].clear
