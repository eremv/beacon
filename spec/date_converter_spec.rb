require 'date_converter'
require 'active_support/all'
require 'date'

RSpec.describe DateConverter, "#convert_date" do
  let(:converter){ DateConverter.new }

  it 'should return one day ago' do
    ["1 day ago", "1 days ago"].each do |period|
        date = converter.convert_date(period)
        expect(date).to eq(1.day.ago.to_i)
    end
  end

  it 'should return one month ago' do
    ["1 month ago", "1 months ago"].each do |period|
      date = converter.convert_date(period)
      expect(date).to eq(1.month.ago.to_i)
    end
  end

  it 'should return one hour ago' do
    ["1 hour ago", "1 hours ago"].each do |period|
      date = converter.convert_date(period)
      expect(date).to eq(1.hour.ago.to_i)
    end
  end

  it 'should return one minutes ago' do
    ["1 minutes ago", "1 minutes ago"].each do |period|
      date = converter.convert_date(period)
      expect(date).to eq(1.minute.ago.to_i)
    end
  end

  it 'should raise ArgumentError if argumants are not valid ' do
    ["", " ", "1 invalid string"].each do |period|
      expect{converter.convert_date(period)}.to raise_error(ArgumentError)
    end
  end

  it 'should raise ArgumentError if argumants predates the start of the beacon ' do
      d = DateTime.strptime("1318996912",'%s')
      d_now = DateTime.now
      difference = (d_now.year - d.year)*12 + (d_now.month - d.month) + 1
      expect{converter.convert_date("#{difference} months ago")}.to raise_error(ArgumentError)
  end
end
