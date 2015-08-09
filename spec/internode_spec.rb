require "spec_helper"

describe Internode do
  after(:each) do
    Internode.client = nil
  end

  it "has a version number" do
    expect(Internode::VERSION).not_to be nil
  end

  it ".client returns a new instance of Client" do
    expect(Internode.client).to be_kind_of(Internode::Client)
  end

  it ".client= sets the client" do
    client = Object.new
    Internode.client = client

    expect(Internode.client).to be(client)
  end
end
