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

    context "with valid prefix" do
      subject { described_class.safe("foo") }

      it "is a salesforce id" do
        is_expected.to be_salesforce_id
      end

      it "begins with prefix" do
        expect(subject.to_s).to start_with("foo")
      end

    end

    context "with too long prefix" do
      subject { described_class.safe("a" * ::SalesforceId::INSENSITIVE_SIZE) }

      it "raises ArgumentError" do
        expect{subject}.to raise_error ArgumentError
      end

    end

    context "with invalid prefix" do
      subject { described_class.safe("a-a") }

      it "raises ArgumentError" do
        expect{subject}.to raise_error ArgumentError
      end

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

    # Useful to ensure that it's not the checksum part having wrong characters
    it "is invalid even if it was of case sensitive size" do
      sensitive = subject[0...::SalesforceId::SENSITIVE_SIZE]

      expect(sensitive).not_to be_salesforce_id
    end

  end

  describe ".invalid_insensitive_checksum" do
    subject { described_class.invalid_insensitive_checksum }

    it "builds a string" do
      is_expected.to be_a String
    end

    it "is of case-insensitive length" do
      expect(subject.size).to eq ::SalesforceId::INSENSITIVE_SIZE
    end

    it "isn't a salesforce id" do
      is_expected.not_to be_salesforce_id
    end

    # Useful to ensure that it's ONLY the checksum part having wrong characters
    it "is valid even if it was of case sensitive size" do
      sensitive = subject[0...::SalesforceId::SENSITIVE_SIZE]

      expect(sensitive).to be_salesforce_id
    end

  end

end
