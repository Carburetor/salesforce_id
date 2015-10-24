require 'spec_helper'

RSpec.describe SalesforceId::Safe do
  let(:error_short_id) { "foo" }
  let(:error_long_id) { "0" * 20 }
  let(:sensitive_id)   { "003G000001SUbc4" }
  let(:insensitive_id) { "003G000001SUbc4IAD" }
  let(:different_id) { "004A000002SUbc4IAD" }
  subject { described_class }

  it "builds correctly with sensitive id" do
    subject.new(sensitive_id)
  end

  it "builds correctly with insensitive id" do
    subject.new(insensitive_id)
  end

  it "can be built by another salesforce id" do
    salesforce_id = subject.new(different_id)

    expect(subject.new(salesforce_id)).to eq salesforce_id
  end

  it "raises when building with invalid id" do
    expect{subject.new(error_short_id)}.to raise_error ArgumentError
  end

  it "raises when building with nil" do
    expect{subject.new(nil)}.to raise_error ArgumentError
  end

  describe "#to_s" do
    subject { described_class.new(sensitive_id) }

    it "is the case insensitive salesforce id" do
      expect(subject.to_s).to eq insensitive_id
    end

    it "is the case insensitive salesforce id but with repaired casing" do
      expect(subject.to_s).not_to eq insensitive_id.downcase
    end

    it "is a frozen string" do
      expect(subject.to_s.frozen?).to be_truthy
    end

  end

  describe "#<=>" do
    subject { described_class.new(sensitive_id) }

    it "can be compared with strings" do
      expect(subject).to eq insensitive_id
    end

    it "is equal to same salesforce id in other format" do
      expect(subject).to eq described_class.new(insensitive_id)
    end

    it "is different from different salesforce id" do
      expect(subject).not_to eq described_class.new(different_id)
    end

  end

  describe "#as_json" do
    subject { described_class.new(sensitive_id) }

    it "outputs a string in case insensitive format" do
      expect(subject.to_json).to eq insensitive_id
    end

  end

  describe "#to_json" do
    subject { described_class.new(sensitive_id) }

    it "outputs a string in case insensitive format" do
      expect(subject.to_json).to eq insensitive_id
    end

  end

  describe "#to_sensitive" do
    subject { described_class.new(sensitive_id) }

    it "is a string with case-sensitive format" do
      expect(subject.to_sensitive).to eq sensitive_id
    end

    it "is not a frozen string" do
      expect(subject.to_sensitive.frozen?).to be_falsy
    end

  end

  describe "#to_insensitive" do
    subject { described_class.new(sensitive_id) }

    it "is a string with case-insensitive format" do
      expect(subject.to_insensitive).to eq insensitive_id
    end

    it "is not a frozen string" do
      expect(subject.to_insensitive.frozen?).to be_falsy
    end

  end

  describe "#dup" do
    subject { described_class.new(sensitive_id) }

    it "is equal to duplicated id" do
      duplicate = subject.dup

      expect(subject).to eq duplicate
    end

  end

end
