require 'salesforce_id/version'
require 'salesforce_id/salesforce_id'
require 'salesforce_id/safe'
require 'salesforce_id/random'

module SalesforceId
  extend self

  # [FixNum] SENSITIVE_SIZE
  # [FixNum] INSENSITIVE_SIZE
  # [Array<String>] VALID_CHARACTERS array of valid characters
  #   for salesforce id

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

  # Creates a salesforce id based on string
  # @param salesforce_id [#to_s] An object that converts to a valid salesforce
  #   id in string format
  # @return [SalesforceId::Safe] the original object if it's already a
  #   {SalesforceId::Safe}, otherwise a generated salesforce id
  # @raise [ArgumentError] if passed id is not valid
  def id(salesforce_id)
    return salesforce_id if salesforce_id.kind_of?(::SalesforceId::Safe)

    ::SalesforceId::Safe.new(salesforce_id)
  end

  # Provides a randomly generated salesforce id using {Salesforce::Random}
  # @return [SalesforceId::Safe]
  def random
    ::SalesforceId::Random.safe
  end

end

# Shortcut for {SalesforceId#id}
def SalesforceId(salesforce_id)
  SalesforceId.id(salesforce_id)
end
