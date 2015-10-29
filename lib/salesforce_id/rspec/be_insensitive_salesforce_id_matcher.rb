require 'salesforce_id'
require 'salesforce_id/rspec'
require 'rspec/expectations'

module ::SalesforceId::RSpec

  module BeInsensitiveSalesforceIdMatcher
    extend RSpec::Matchers::DSL

    matcher :be_insensitive_salesforce_id do
      match { |id| SalesforceId.insensitive?(id) }
    end

  end

end
