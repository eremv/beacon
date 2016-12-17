require 'responce_processor'


RSpec.describe ResponceProcessor, "#get_responce" do
  let(:resp){ ResponceProcessor.new }
  let(:body){"<record xmlns=\"http://beacon.nist.gov/record/0.1/\"></record>" }

  before do
    stub_request(:get, "https://beacon.nist.gov/rest/record/last").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => body, :headers => {})

  end

  it 'should return responce' do
    resp.get_responce "https://beacon.nist.gov/rest/record/last"
    expect(resp.responce).to_not be_nil
  end
end


RSpec.describe ResponceProcessor, "#get_output_value" do
  let(:resp){ ResponceProcessor.new }
  let(:body){"<record xmlns=\"http://beacon.nist.gov/record/0.1/\"><outputValue>10670CF34F03A91B5C01C7</outputValue></record>" }

  it 'should return output value on correct body' do
    stub_request(:get, "https://beacon.nist.gov/rest/record/last").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => body, :headers => {})
    resp.get_responce "https://beacon.nist.gov/rest/record/last"
    expect(resp.get_output_value).to eq "10670CF34F03A91B5C01C7"
  end

  it 'should return nothing on correct body' do
    stub_request(:get, "https://beacon.nist.gov/rest/record/last").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "", :headers => {})
    resp.get_responce "https://beacon.nist.gov/rest/record/last"
    expect(resp.get_output_value).to eq ""
  end
end

RSpec.describe ResponceProcessor, "#get_timestamp_value" do
  let(:resp){ ResponceProcessor.new }
  let(:body){"<timeStamp>1481991060</timeStamp>"}

  it 'should return timestamp' do
    stub_request(:get, "https://beacon.nist.gov/rest/record/last").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => body, :headers => {})
    resp.get_responce "https://beacon.nist.gov/rest/record/last"
    expect(resp.get_timestamp_value).to eq "1481991060"
  end

  it 'should return nothing if timestamp missing' do
    stub_request(:get, "https://beacon.nist.gov/rest/record/last").
        with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "<outputValue>10670CF34F03A91B5C01C7</outputValue>", :headers => {})
    resp.get_responce "https://beacon.nist.gov/rest/record/last"
    expect(resp.get_timestamp_value).to eq ""
  end

end
