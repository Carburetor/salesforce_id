require 'salesforce_id'
require 'salesforce_id/rspec'
require 'rspec/expectations'

module ::SalesforceId::RSpec

  module BeSensitiveSalesforceIdMatcher
    extend RSpec::Matchers::DSL

    matcher :be_sensitive_salesforce_id do
      match { |id| SalesforceId.sensitive?(id) }
    end

  end

end
