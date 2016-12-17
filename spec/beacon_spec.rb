require 'beacon'

RSpec.describe Beacon, "#process" do
  let(:beacon){ Beacon.new }

  subject{:beacon}

  it 'should return hash of signs count' do
    res = beacon.process "01AF04F"
    expect(res).to include("0" => 2, "1" => 1, "4" => 1, "A" => 1, "F" => 2)
  end

  it 'should return empty hash' do
    res = beacon.process ""
    expect(res).to eq({})
  end

  it 'should return one component hash from 1 symbol line' do
    res = beacon.process "A"
    expect(res).to eq({"A" => 1})
  end
end
