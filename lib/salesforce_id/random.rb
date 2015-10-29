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
    # one **invalid character in the case-sensitive part** (first 15
    # characters), making it invalid
    # @return [String]
    def invalid_insensitive
      id = insensitive

      id[rand(::SalesforceId::SENSITIVE_SIZE)] = '-'

      id
    end

    # Create a random salesforce id in case-insensitive format with
    # one **invalid character in the case-insensitive part** (last 3 characters   # from 15 to 18), making it invalid
    # @return [String]
    def invalid_insensitive_checksum
      id             = insensitive
      checksum_size  = ::SalesforceId::INSENSITIVE_SIZE
      checksum_size -= ::SalesforceId::SENSITIVE_SIZE

      # Gets a random number between -1 and -3 and set that char to a valid
      # case-sensitive character which is however invalid for case-insensitive
      # id
      id[(-checksum_size) + rand(checksum_size)] = '9'

      id
    end

    # Creates a random salesforce id enclosed in {SalesforceId::Safe} object
    # @return [SalesforceId::Safe]
    def safe
      SalesforceId(sensitive)
    end

  end

end
