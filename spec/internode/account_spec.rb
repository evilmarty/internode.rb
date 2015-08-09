require "spec_helper"

describe Internode::Account do
  describe "initialize" do
    it "instantiates a new client using the username and password specified" do
      fake_client = class_double("Internode::Client").as_stubbed_const
      expect(fake_client).to receive(:new).with(username: "abc", password: "123")

      Internode::Account.new(username: "abc", password: "123")
    end

    it "sets the client to the one specified" do
      client = Object.new
      account = Internode::Account.new(client: client)

      expect(account.client).to be(client)
    end

    it "sets the path to the one specified" do
      account = Internode::Account.new(path: "/foobar")
      expect(account.path).to eq("/foobar")
    end

    it "defaults the path when none specified" do
      account = Internode::Account.new
      expect(account.path).to eq("/api/v1.5")
    end
  end

  describe "services", vcr: { cassette_name: "account" } do
    let(:account){ Internode::Account.new(username: "user", password: "pass") }

    it "returns a collection of services" do
      expect(account.services).to all(be_kind_of(Internode::Service))
    end

    it "passes its client to the service" do
      expect(account.services[0].client).to be(account.client)
    end

    it "sets the service's path from its xml href entry" do
      expect(account.services[0].path).to eq("/api/v1.5/1")
    end
  end

  describe "details" do
    let(:account){ Internode::Account.new }

    it "returns the details for all the account's services" do
      details = Object.new
      service = instance_double(Internode::Service, details: details)
      allow(account).to receive(:services){ [service] }

      expect(account.details).to eq([details])
    end
  end

  describe "usage" do
    let(:account){ Internode::Account.new }

    it "returns the usage for all the account's services" do
      usage = Object.new
      service = instance_double(Internode::Service, usage: usage)
      allow(account).to receive(:services){ [service] }

      expect(account.usage).to eq([usage])
    end
  end
end
