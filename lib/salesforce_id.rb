require 'salesforce_id/version'
require 'salesforce_id/salesforce_id'
require 'salesforce_id/safe'

module SalesforceId
  extend self

  def id(salesforce_id)
    return salesforce_id if salesforce_id.kind_of?(::SalesforceId::Safe)

    ::SalesforceId::Safe.new(salesforce_id)
  end

  # [FixNum] SENSITIVE_SIZE
  # [FixNum] INSENSITIVE_SIZE

  # to_sensitive
  # @param id [String]
  # @return [String]

  # to_insensitive
  # @param id [String]
  # @return [String]

  # valid?
  # @param id [String]
  # @return [Boolean]

  # repair_casing
  # @param id [String]
  # @return [String]

  # sensitive?
  # @param id [String]
  # @return [Boolean]

  # insensitive?
  # @param id [String]
  # @return [Boolean]

end

def SalesforceId(salesforce_id)
  SalesforceId.id(salesforce_id)
end
