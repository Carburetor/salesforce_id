require 'salesforce_id'
require 'salesforce_id/rspec'
require 'rspec/expectations'

module ::SalesforceId::RSpec

  module BeSafeSalesforceIdMatcher
    extend RSpec::Matchers::DSL

    matcher :be_safe_salesforce_id do
      match do |id|
        SalesforceId.valid?(id) && SalesforceId(id).to_s == id.to_s
      end
    end

  end

end
