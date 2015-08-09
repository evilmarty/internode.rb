require "spec_helper"

describe Internode::Resource do
  before(:each) do
    Internode.client = Internode::Client.new(username: "user", password: "pass")
  end

  describe "initialize" do
    it "sets the path to the one specified" do
      resource = Internode::Resource.new(path: "/foo")
      expect(resource.path).to eq("/foo")
    end

    it "sets the client to the one specified" do
      client = Object.new
      resource = Internode::Resource.new(client: client)

      expect(resource.client).to be(client)
    end

    it "defaults the client when non specified" do
      resource = Internode::Resource.new
      expect(resource.client).to be(Internode.client)
    end
  end

  describe "content" do
    it "returns an xml element", vcr: { cassette_name: "account" } do
      resource = Internode::Resource.new(path: "/api/v1.5")
      expect(resource.content).to be_kind_of(Oga::XML::Element)
    end
  end

  describe "content_attr", vcr: { cassette_name: "test_content_attr" } do
    let(:resource_class){
      klass = Class.new(Internode::Resource)
      klass.content_attr("foobar", "foo-bar")
      klass
    }
    let(:instance){ resource_class.new(path: "/test/content_attr") }

    it "defines methods a name specified" do
      expect(instance).to respond_to(:foobar)
    end

    it "defines method from a hyphenated name specified" do
      expect(instance).to respond_to(:foo_bar)
    end

    it "defines a method that returns the text corresponding to the content" do
      expect(instance.foobar).to eq("yep")
    end
  end
end
