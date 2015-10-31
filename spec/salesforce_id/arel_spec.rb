require 'spec_helper'
require 'arel'
require 'salesforce_id/arel/visitor'

RSpec.describe "Arel injection" do
  let!(:fake_arel) do
    ::Arel::Visitors::ToSql.tap do |klass|
      allow(klass).to receive(:include).and_call_original
    end
  end
  let(:arel_injector) do
    SALESFORCE_ID_ROOT_PATH.join('lib', 'salesforce_id', 'arel.rb').to_s
  end
  subject { fake_arel }

  it "injects ::SalesforceId::Arel::Visitor if injectable" do
    allow(::SalesforceId::Arel::Visitor).to receive(:injectable?).
      and_return(true)

    load(arel_injector)

    is_expected.to have_received(:include).with(::SalesforceId::Arel::Visitor)
  end

  it "doesn't ::SalesforceId::Arel::Visitor if not injectable" do
    allow(::SalesforceId::Arel::Visitor).to receive(:injectable?).
      and_return(false)

    load(arel_injector)

    is_expected.not_to have_received(:include)
  end

end
