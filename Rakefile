require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => [:compile, :spec]
require "rake/extensiontask"

task :build => :compile

Rake::ExtensionTask.new("salesforce_id") do |ext|
  ext.lib_dir = "lib/salesforce_id"
end
