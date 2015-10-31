module ::SalesforceId

  module Arel

    module Visitor

      def visit_SalesforceId_Safe(o, collector)
        quoted(o.to_s, collector)
      end

    end

  end

end
