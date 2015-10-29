require 'salesforce_id'

module ::SalesforceId

  # Factory for random generation of salesforce ids
  module Random
    extend self

    # Creates a random salesforce id in case-sensitive format
    # @return [String]
    def sensitive
      id = ""

      # Fetch samples in this way to allow repetition of values
      ::SalesforceId::SENSITIVE_SIZE.times do
        id << ::SalesforceId::VALID_CHARACTERS.sample
      end

      id
    end

    # Creates a random salesforce id in case-insensitive format
    # @return [String]
    def insensitive
      safe.to_insensitive
    end

    # Create a random salesforce id in case-sensitive format with
    # one invalid character, making it invalid
    # @return [String]
    def invalid_sensitive
      id = sensitive

      id[rand(id.size)] = '-'

      id
    end

    # Create a random salesforce id in case-insensitive format with
    # one invalid character, making it invalid
    # @return [String]
    def invalid_insensitive
      id = insensitive

      id[rand(id.size)] = '-'

      id
    end

    # Creates a random salesforce id enclosed in {SalesforceId::Safe} object
    # @return [SalesforceId::Safe]
    def safe
      SalesforceId(sensitive)
    end

  end

end
