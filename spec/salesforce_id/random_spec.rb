require 'spec_helper'
require 'salesforce_id'
require 'salesforce_id/safe'
require 'salesforce_id/random'
require 'salesforce_id/rspec'

RSpec.describe ::SalesforceId::Random do
  include ::SalesforceId::RSpec

  subject { described_class }

  describe ".sensitive" do
    subject { described_class.sensitive }

    it "builds a string" do
      is_expected.to be_a String
    end

    it "is of case-sensitive length" do
      expect(subject.size).to eq ::SalesforceId::SENSITIVE_SIZE
    end

    it "is a salesforce id" do
      is_expected.to be_salesforce_id
    end

    it "is a case-sensitive id" do
      is_expected.to be_sensitive_salesforce_id
    end

  end

  describe ".insensitive" do
    subject { described_class.insensitive }

    it "builds a string" do
      is_expected.to be_a String
    end

    it "is of case-insensitive length" do
      expect(subject.size).to eq ::SalesforceId::INSENSITIVE_SIZE
    end

    it "is a salesforce id" do
      is_expected.to be_salesforce_id
    end

    it "is a case-insensitive id" do
      is_expected.to be_insensitive_salesforce_id
    end

  end

  describe ".safe" do
    subject { described_class.safe }

    it "builds a safe id" do
      is_expected.to be_a ::SalesforceId::Safe
    end

    it "is a salesforce id" do
      is_expected.to be_salesforce_id
    end

  end

  describe ".invalid_sensitive" do
    subject { described_class.invalid_sensitive }

    it "builds a string" do
      is_expected.to be_a String
    end

    it "is of case-sensitive length" do
      expect(subject.size).to eq ::SalesforceId::SENSITIVE_SIZE
    end

    it "isn't a salesforce id" do
      is_expected.not_to be_salesforce_id
    end

  end

  describe ".invalid_insensitive" do
    subject { described_class.invalid_insensitive }

    it "builds a string" do
      is_expected.to be_a String
    end

    it "is of case-insensitive length" do
      expect(subject.size).to eq ::SalesforceId::INSENSITIVE_SIZE
    end

    it "isn't a salesforce id" do
      is_expected.not_to be_salesforce_id
    end

  end

end
