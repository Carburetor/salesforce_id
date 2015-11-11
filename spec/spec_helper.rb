if ENV['CODECLIMATE_REPO_TOKEN']
  puts "Code climate test coverage enabled"
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

unless ENV['IGNORE_BUNDLER']
  require 'bundler'
  Bundler.setup(:default, :test, ENV['RAILS_ENV'])
end

require 'pry-byebug' if Gem::Specification.find_by_name('pry-byebug')
require 'pathname'
require 'salesforce_id'

SALESFORCE_ID_ROOT_PATH = Pathname.new(File.expand_path('../../', __FILE__).to_s)

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  if ENV['all'].nil?
    config.filter_run focus: true
  end
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!
  config.default_formatter = 'doc' if config.files_to_run.one?
  config.order = :random
  Kernel.srand config.seed
end
