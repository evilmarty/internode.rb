require "spec_helper"

describe Internode::Client do
  describe "initialize" do
    let(:http_client){ double }

    before(:each) do
      class_double("HTTPClient", new: http_client).as_stubbed_const
      allow(http_client).to receive(:cookie_manager=)
    end

    after(:each) do
      ENV["INTERNODE_USERNAME"] = nil
      ENV["INTERNODE_PASSWORD"] = nil
    end

    it "sets client auth with specified url" do
      expect(http_client).to receive(:set_auth).with("foobar", nil, nil)

      client = Internode::Client.new(url: "foobar")
    end

    it "sets client auth with specified username" do
      expect(http_client).to receive(:set_auth).with(nil, "foobar", nil)

      client = Internode::Client.new(username: "foobar", url: nil)
    end

    it "sets client auth with specified password" do
      expect(http_client).to receive(:set_auth).with(nil, nil, "foobar")

      client = Internode::Client.new(password: "foobar", url: nil)
    end

    it "sets client auth with environment variables" do
      ENV["INTERNODE_USERNAME"] = "foo"
      ENV["INTERNODE_PASSWORD"] = "bar"

      expect(http_client).to receive(:set_auth).with(nil, "foo", "bar")

      client = Internode::Client.new(username: "foo", password: "bar", url: nil)
    end
  end

  describe ".get" do
    it "returns an xml element", vcr: { cassette_name: "account" } do
      element = Internode::Client.new(username: "user", password: "pass").get("/api/v1.5")
      expect(element).to be_kind_of(Oga::XML::Element)
    end

    it "raises an error", vcr: { cassette_name: "error" } do
      expect{
        Internode::Client.new(username: "nope", password: "nope").get("/api/v1.5")
      }.to raise_error(Internode::Client::ServerError)
    end
  end
end
