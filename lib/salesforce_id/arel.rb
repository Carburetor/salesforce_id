require 'rubygems'
require 'salesforce_id/arel/visitor'

if ::SalesforceId::Arel::Visitor.injectable?
  ::Arel::Visitors::ToSql.send(:include, ::SalesforceId::Arel::Visitor)
end
