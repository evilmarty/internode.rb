require "spec_helper"

describe Internode::Usage, vcr: { cassette_name: "usage" }, wip: true do
  let(:client){ Internode::Client.new(username: "user", password: "pass") }
  let(:usage){ Internode::Usage.new(client: client, path: "/api/v1.5/1/usage") }

  it "has the id" do
    expect(usage.id).to eq("1")
  end

  it "has the type" do
    expect(usage.type).to eq("Personal_ADSL")
  end

  it "has the total" do
    expect(usage.total).to eq(1234567890)
  end

  it "has the total in Mb" do
    expect(usage.total_mb).to eq(1234)
  end

  it "has the total in Gb" do
    expect(usage.total_gb).to eq(1)
  end

  it "has the rollover" do
    expect(usage.rollover).to eq("2015-01-01")
  end

  it "has the plan interval" do
    expect(usage.plan_interval).to eq("Monthly")
  end

  it "has the type" do
    expect(usage.type).to eq("Personal_ADSL")
  end

  it "has the quota" do
    expect(usage.quota).to eq(100000000000)
  end

  it "has the quota in Mb" do
    expect(usage.quota_mb).to eq(100000)
  end

  it "has the quota in Gb" do
    expect(usage.quota_gb).to eq(100)
  end

  it "has the percentage used" do
    expect(usage.percentage).to be_within(0.01).of(1.23)
  end
end
