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

end
