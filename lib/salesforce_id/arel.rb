require 'rubygems'

arel_is_present   = defined?(::Arel)
arel_is_present &&= Gem::Dependency.new('arel', '~> 5.0')
                                   .match?('arel', ::Arel::VERSION)

if arel_is_present
  require 'arel'
  require 'salesforce_id/arel/visitor'

  ::Arel::Visitors::ToSql.send(:include, ::SalesforceId::Arel::Visitor)
end
