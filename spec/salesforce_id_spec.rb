require 'spec_helper'
require 'salesforce_id'
require 'salesforce_id/safe'

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

  it "has array of valid characters of size 62" do
    expect(subject::VALID_CHARACTERS.size).to eq 62
  end

  it "has an array of valid characters" do
    valid_chars = ('a'..'z').to_a
    valid_chars = valid_chars.concat(('A'..'Z').to_a)
    valid_chars = valid_chars.concat(('0'..'9').to_a)

    expect(subject::VALID_CHARACTERS).to eq valid_chars
  end

  it "has an array of valid characters frozen" do
    expect(subject::VALID_CHARACTERS).to be_frozen
  end

  it "has an array of valid characters where all of them are frozen" do
    expect(subject::VALID_CHARACTERS).to all be_frozen
  end

  it "when called as a method it performs .id" do
    allow(SalesforceId).to receive(:id)

    SalesforceId("foo")

    expect(subject).to have_received(:id)
  end

  describe ".valid?" do

    it "is valid salesforce id" do
      expect(subject.valid?(sensitive_id)).to be_truthy
    end

    it "is invalid when length is short" do
      expect(subject.valid?(error_short_id)).to be_falsy
    end

    it "is invalid when length is long" do
      expect(subject.valid?(error_long_id)).to be_falsy
    end

    it "is invalid when nil" do
      expect(subject.valid?(nil)).to be_falsy
    end

    it "is invalid when of valid length but with invalid chars" do
      sensitive_id[1] = "-"

      expect(subject.valid?(sensitive_id)).to be_falsy
    end

  end

  describe ".to_insensitive" do

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

  describe ".to_sensitive" do

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

  describe ".repair_casing" do
    let(:broken_insensitive_id) { insensitive_id.downcase }

    it "restores correct casing" do
      expect(subject.repair_casing(broken_insensitive_id)).to eq insensitive_id
    end

    it "restores casing even if already correct" do
      expect(subject.repair_casing(insensitive_id)).to eq insensitive_id
    end

    it "raises if invalid salesforce id" do
      expect{subject.repair_casing(error_short_id)}.to raise_error ArgumentError
    end

    it "raises if sensitive salesforce id passed" do
      expect{subject.repair_casing(sensitive_id)}.to raise_error ArgumentError
    end

    it "raises if nil passed" do
      expect{subject.repair_casing(nil)}.to raise_error ArgumentError
    end

  end

  describe ".sensitive?" do

    it "is true when id is sensitive" do
      expect(subject.sensitive?(sensitive_id)).to be_truthy
    end

    it "is false when id is not sensitive" do
      expect(subject.sensitive?(insensitive_id)).to be_falsy
    end

    it "is false when id is nil" do
      expect(subject.sensitive?(nil)).to be_falsy
    end

    it "is false when id is invalid" do
      expect(subject.sensitive?(error_short_id)).to be_falsy
    end

  end

  describe ".insensitive?" do

    it "is true when id is insensitive" do
      expect(subject.insensitive?(insensitive_id)).to be_truthy
    end

    it "is false when id is not insensitive" do
      expect(subject.insensitive?(sensitive_id)).to be_falsy
    end

    it "is false when id is nil" do
      expect(subject.insensitive?(nil)).to be_falsy
    end

    it "is false when id is invalid" do
      expect(subject.insensitive?(error_short_id)).to be_falsy
    end

  end

  describe ".id" do

    it "builds a safe salesforce id" do
      expect(subject.id(sensitive_id)).to be_an_instance_of(subject::Safe)
    end

    it "doesn't build a salesforce id if it's already an id" do
      salesforce_id = subject.id(insensitive_id)

      expect(subject.id(salesforce_id)).to equal salesforce_id
    end

  end

end
