require 'rubygems'

if defined?(::Arel) && Gem::Dependency.new('arel', '~> 5.0').match?('arel', ::Arel::VERSION)
  require 'arel'
  require 'salesforce_id/arel/visitor'

  ::Arel::Visitors::ToSql.send(:include, ::SalesforceId::Arel::Visitor)
end
