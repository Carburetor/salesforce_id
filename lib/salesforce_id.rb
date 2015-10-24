require 'salesforce_id/version'
require 'salesforce_id/salesforce_id'
require 'salesforce_id/safe'

module SalesforceId
  extend self

  def id(salesforce_id)
    return salesforce_id if salesforce_id.kind_of?(::SalesforceId::Safe)

    ::SalesforceId::Safe.new(salesforce_id)
  end

end
