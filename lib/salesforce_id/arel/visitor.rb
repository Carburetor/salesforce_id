module ::SalesforceId

  module Arel

    module Visitor
      AREL_REQUIRED_VERSION = "5.0".freeze

      def visit_SalesforceId_Safe(o, collector)
        quoted(o.to_s, collector)
      end

      def self.injectable?
        defined?(::Arel) &&
        Gem::Dependency.new('arel', "~> #{ AREL_REQUIRED_VERSION }").
          match?('arel', ::Arel::VERSION)
      end

    end

  end

end
