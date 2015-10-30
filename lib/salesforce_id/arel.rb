require 'rubygems'

if defined?(::Arel) && Gem::Dependency.new('arel', '~> 5.0').match?('arel', ::Arel::VERSION)

  class ::Arel::Visitors::ToSql

    def visit_SalesforceId_Safe(o, collector)
      quoted(o.to_s, collector)
    end

  end

end
