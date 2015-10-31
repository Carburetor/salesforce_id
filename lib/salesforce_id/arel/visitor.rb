module ::SalesforceId

  module Arel

    module Visitor

      def visit_SalesforceId_Safe(o, collector)
        quoted(o.to_s, collector)
      end

      def self.injectable?
        defined?(::Arel) &&
        Gem::Dependency.new('arel', "~> 5.0").
          match?('arel', ::Arel::VERSION)
      end

    end

  end

end
