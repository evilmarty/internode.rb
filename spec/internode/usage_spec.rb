require "spec_helper"

describe Internode::Details, vcr: { cassette_name: "details" } do
  let(:client){ Internode::Client.new(username: "user", password: "pass") }
  let(:details){ Internode::Details.new(client: client, path: "/api/v1.5/1/service") }

  it "has the id" do
    expect(details.id).to eq("1")
  end

  it "has the username" do
    expect(details.username).to eq("example@internode.on.net")
  end

  it "has the plan" do
    expect(details.plan).to eq("Easy Naked 100 Special")
  end

  it "has the carrier" do
    expect(details.carrier).to eq("Internode")
  end

  it "has the speed" do
    expect(details.speed).to eq("24 Mbits/sec")
  end

  it "has the usage rating" do
    expect(details.usage_rating).to eq("up+down")
  end

  it "has the rollover" do
    expect(details.rollover).to eq("2015-01-01")
  end

  it "has the excess charged" do
    expect(details.excess_charged).to eq("no")
  end

  it "has the excess shaped" do
    expect(details.excess_shaped).to eq("yes")
  end

  it "has the excess restrict access" do
    expect(details.excess_restrict_access).to eq("no")
  end

  it "has the plan interval" do
    expect(details.plan_interval).to eq("Monthly")
  end

  it "has the plan cost" do
    expect(details.plan_cost).to eq("99.99")
  end

  it "has the type" do
    expect(details.type).to eq("Personal_ADSL")
  end

  it "has the quota" do
    expect(details.quota).to eq(100000000000)
  end

  it "has the quota in Mb" do
    expect(details.quota_mb).to eq(100000)
  end

  it "has the quota in Gb" do
    expect(details.quota_gb).to eq(100)
  end
end
