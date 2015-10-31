require 'salesforce_id/rspec/be_sensitive_salesforce_id_matcher'
require 'salesforce_id/rspec/be_insensitive_salesforce_id_matcher'
require 'salesforce_id/rspec/be_salesforce_id_matcher'
require 'salesforce_id/rspec/be_safe_salesforce_id_matcher'

module SalesforceId

  module RSpec
    include ::SalesforceId::RSpec::BeSensitiveSalesforceIdMatcher
    include ::SalesforceId::RSpec::BeInsensitiveSalesforceIdMatcher
    include ::SalesforceId::RSpec::BeSalesforceIdMatcher
    include ::SalesforceId::RSpec::BeSafeSalesforceIdMatcher
  end

end
