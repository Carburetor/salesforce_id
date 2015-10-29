require 'salesforce_id'
require 'salesforce_id/rspec'
require 'rspec/expectations'

module ::SalesforceId::RSpec

  module BeSalesforceIdMatcher
    extend RSpec::Matchers::DSL

    matcher :be_salesforce_id do
      match { |id| SalesforceId.valid?(id) }
    end

  end

end
