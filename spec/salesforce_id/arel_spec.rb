require 'spec_helper'
require 'arel'
require 'salesforce_id/arel/visitor'

RSpec.describe "Arel injection" do
  let!(:fake_arel) do
    class_double("::Arel::Visitors::ToSql", include: nil).as_stubbed_const
  end
  let(:arel_injector) do
    SALESFORCE_ID_ROOT_PATH.join('lib', 'salesforce_id', 'arel.rb').to_s
  end
  let(:gem_dependency) { double("Gem::Dependency", match?: true) }
  subject { fake_arel }

  it "injects ::SalesforceId::Arel::Visitor" do
    stub_const("::Arel::VERSION", "5.0.0")

    load(arel_injector)

    is_expected.to have_received(:include).with(::SalesforceId::Arel::Visitor)
  end

  it "doesn't inject if arel is not defined" do
    hide_const("::Arel")

    load(arel_injector)

    is_expected.not_to have_received(:include)
  end

  it "doesn't inject if Arel is not version 5" do
    stub_const("::Arel::VERSION", "6.0.0")

    load(arel_injector)

    is_expected.not_to have_received(:include)
  end

end
