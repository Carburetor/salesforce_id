require 'spec_helper'
require 'salesforce_id'
require 'salesforce_id/arel/visitor'

RSpec.describe ::SalesforceId::Arel::Visitor do
  let(:arel_collector) { double("ArelCollector") }
  let(:dummy_to_sql_class) do
    Class.new do
      include ::SalesforceId::Arel::Visitor

      def quoted(str, collector)
      end

    end
  end
  subject { dummy_to_sql_class.new }

  it { is_expected.to respond_to(:visit_SalesforceId_Safe) }

  it "calls quoted with first argument salesforce id as string" do
    allow(subject).to receive(:quoted).and_call_original
    salesforce_id = ::SalesforceId.random

    subject.visit_SalesforceId_Safe(salesforce_id, arel_collector)

    is_expected.to have_received(:quoted).with(salesforce_id.to_s, arel_collector)
  end

  describe ".injectable?" do
    subject { described_class }

    it "is injectable when Arel defined and of version AREL_REQUIRED_VERSION" do
      stub_const("::Arel", Object)
      stub_const("::Arel::VERSION", "5.0.0")

      is_expected.to be_injectable
    end

    it "is not injectable if Arel not defined" do
      hide_const("::Arel")

      is_expected.not_to be_injectable
    end

    it "is not injectable if Arel version doesn't match required" do
      stub_const("::Arel", Object)
      stub_const("::Arel::VERSION", "9999999.999.999")

      is_expected.not_to be_injectable
    end

  end

end
