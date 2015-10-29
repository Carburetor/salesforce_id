require 'spec_helper'
require 'salesforce_id'
require 'salesforce_id/rspec'

RSpec.describe ::SalesforceId::RSpec do
  include ::SalesforceId::RSpec
  subject { SalesforceId("003G000001SUbc4") }

  describe "#be_sensitive_salesforce_id" do

    it "is true when id is sensitive" do
      expect(subject.to_sensitive).to be_sensitive_salesforce_id
    end

    it "is false when id is not sensitive" do
      expect(subject.to_insensitive).not_to be_sensitive_salesforce_id
    end

    it "is false when id is not valid" do
      expect("foo").not_to be_sensitive_salesforce_id
    end

  end

  describe "#be_insensitive_salesforce_id" do

    it "is true when id is insensitive" do
      expect(subject.to_insensitive).to be_insensitive_salesforce_id
    end

    it "is false when id is not insensitive" do
      expect(subject.to_sensitive).not_to be_insensitive_salesforce_id
    end

    it "is false when id is not valid" do
      expect("foo").not_to be_insensitive_salesforce_id
    end

  end

  describe "#be_salesforce_id" do

    it "is a salesforce id when is insensitive" do
      expect(subject.to_insensitive).to be_salesforce_id
    end

    it "is a salesforce id when is sensitive" do
      expect(subject.to_sensitive).to be_salesforce_id
    end

    it "isn't a salesforce id when it's not valid" do
      expect("foo").not_to be_salesforce_id
    end

  end

  describe "#be_safe_salesforce_id" do

    it "is a safe salesforce id" do
      is_expected.to be_safe_salesforce_id
    end

    it "is not safe salesforce id when in case sensitive format" do
      expect(subject.to_sensitive).not_to be_safe_salesforce_id
    end

    it "is safe even when converted to string format" do
      expect(subject.to_s).to be_safe_salesforce_id
    end

    it "isn't a safe salesforce id when it's not valid" do
      expect("foo").not_to be_safe_salesforce_id
    end

    it "isn't safe when not case-sensitive + checksum format" do
      expect(subject.to_s.downcase).to be_safe_salesforce_id
    end

  end

end
