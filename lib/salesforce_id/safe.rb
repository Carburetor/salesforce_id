require 'salesforce_id'
require 'salesforce_id/safe'

module SalesforceId

  # Rapresents a salesforce id as an object allowing for comparison and usage
  # in a safe fashion thanks to using fixed format. Internally will store and
  # keep any salesforce id using the case-insensitive format but with repaired
  # casing, which should offer maximum safety
  class Safe
    include Comparable

    # @param id [String] valid salesforce id
    def initialize(id)
      id = id.to_s

      unless ::SalesforceId.valid?(id)
        raise ArgumentError, "Salesforce ID not valid"
      end

      @value = SalesforceId.to_insensitive(id.dup).freeze
    end

    # @return [String] text composing salesforce id, string is **frozen**
    def to_s
      value
    end

    def as_json(*)
      to_s
    end

    # In JSON format, it's a plain string
    def to_json(*)
      as_json
    end

    # Comparison with string is avoided because otherwise either it needed to
    # allocate a salesforce id or it would fail if not in case insensitive
    # format
    # @param other [SalesforceId::Safe]
    def <=>(other)
      return nil unless other.is_a?(self.class)

      to_s <=> other.to_s
    end

    # @return [String] salesforce id in case-sensitive format, string is **not**
    # frozen
    def to_sensitive
      SalesforceId.to_sensitive(value)
    end

    # @return [String] salesforce id in case-insensitive format, string is
    # **not** frozen
    def to_insensitive
      to_s.dup
    end

    protected

    # Internal value of salesforce safe id
    attr_reader :value

  end

end
