require_relative 'date_converter'
require 'nokogiri'
require 'open-uri'
require 'pry'


class ResponceProcessor
  attr_accessor :responce

  CURRENT = "https://beacon.nist.gov/rest/record/last"
  AT_TIME = "https://beacon.nist.gov/rest/record/"
  NEXT = "https://beacon.nist.gov/rest/record/next/"


  def get_responce url
    begin
      @responce = Nokogiri::XML(open(url))
    rescue OpenURI::HTTPError => e
      puts "Can't access #{ url }"
      puts e.message
    end
  end

  def get_output_value
    @responce.css("outputValue").text unless @responce.nil?
  end

  def get_timestamp_value
    @responce.css("timeStamp").text unless @responce.nil?
  end

  def get_recent
    get_responce CURRENT
    @responce.css("outputValue").text unless @responce.nil?
  end

  def get_at_time time
    get_responce AT_TIME+time.to_s
  end

  def get_next time
    get_responce NEXT+time.to_s
  end


  def get_for_period from, to
    converter = DateConverter.new
    outputs=[]
    current_time = converter.convert_date from

    end_time  = converter.convert_date to

    while current_time < end_time do

      get_next current_time
      outputs.push(get_output_value)
      current_time = get_timestamp_value.to_i
    end
    outputs
  end

end
