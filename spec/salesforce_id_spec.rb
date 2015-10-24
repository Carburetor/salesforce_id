require 'spec_helper'

RSpec.describe SalesforceId do
  let(:error_short_id) { "foo" }
  let(:error_long_id) { "0" * 20 }
  let(:sensitive_id)   { "003G000001SUbc4" }
  let(:insensitive_id) { "003G000001SUbc4IAD" }
  subject { described_class }

  it "has a version number" do
    expect(subject::VERSION).not_to be_nil
  end

  it "has sensitive size constant" do
    expect(subject::SENSITIVE_SIZE).to eq 15
  end

  it "has insensitive size constant" do
    expect(subject::INSENSITIVE_SIZE).to eq 18
  end

  describe "#valid?" do

    it "is valid salesforce id" do
      expect(subject.valid?(sensitive_id)).to be_truthy
    end

    it "is invalid when length is short" do
      expect(subject.valid?(error_short_id)).to be_falsy
    end

    it "is invalid when length is long" do
      expect(subject.valid?(error_long_id)).to be_falsy
    end

    it "is invalid when contains invalid characters" do
      insensitive_id[-1] = "9"

      expect(subject.valid?(insensitive_id)).to be_falsy
    end

    it "is invalid when nil" do
      expect(subject.valid?(nil)).to be_falsy
    end

  end

  describe "#to_insensitive" do

    it "converts correctly" do
      expect(subject.to_insensitive(sensitive_id)).to eq insensitive_id
    end

    it "doesn't perform conversion if id is already insensitive" do
      expect(subject.to_insensitive(insensitive_id)).to eq insensitive_id
    end

    it "raises when salesforce id is invalid" do
      expect{subject.to_insensitive(error_long_id)}.to raise_error ArgumentError
    end

    it "raises when nil is passed" do
      expect{subject.to_insensitive(nil)}.to raise_error ArgumentError
    end

  end

  describe "#to_sensitive" do

    it "converts correctly" do
      expect(subject.to_sensitive(insensitive_id)).to eq sensitive_id
    end

    it "converts correctly to sensitive even when case is wrong" do
      expect(subject.to_sensitive(insensitive_id.downcase)).to eq sensitive_id
    end

    it "doesn't perform conversion if id is already sensitive" do
      expect(subject.to_sensitive(sensitive_id)).to eq sensitive_id
    end

    it "raises when salesforce id is invalid" do
      expect{subject.to_sensitive(error_long_id)}.to raise_error ArgumentError
    end

    it "raises when salesforce id contains invalid characters" do
      insensitive_id[-1] = "9"

      expect{subject.to_sensitive(insensitive_id)}.to raise_error ArgumentError
    end

    it "raises when nil is passed" do
      expect{subject.to_sensitive(nil)}.to raise_error ArgumentError
    end

  end

end
