require "spec_helper"

describe Internode::Service, vcr: { cassette_name: "service" } do
  let(:client){ Internode::Client.new(username: "user", password: "pass") }
  let(:service){ Internode::Service.new(client: client, path: "/api/v1.5/1") }

  it "has the id" do
    expect(service.id).to eq("1")
  end

  it "has the type" do
    expect(service.type).to eq("Personal_ADSL")
  end

  describe "details" do
    it "returns the service's details" do
      expect(service.details).to be_kind_of(Internode::Details)
    end

    it "sets the details path" do
      expect(service.details.path).to eq("/api/v1.5/1/service")
    end

    it "passes its client onto the details" do
      expect(service.details.client).to be(client)
    end
  end

  describe "usage" do
    it "returns the service's usage" do
      expect(service.usage).to be_kind_of(Internode::Usage)
    end

    it "sets the usage path" do
      expect(service.usage.path).to eq("/api/v1.5/1/usage")
    end

    it "passes its client onto the usage" do
      expect(service.usage.client).to be(client)
    end
  end
end
