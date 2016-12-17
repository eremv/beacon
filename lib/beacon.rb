require 'nokogiri'
require 'open-uri'


class Beacon

  attr_accessor :responce
  attr_accessor :res

  CURRENT = "https://beacon.nist.gov/rest/record/last"


  def get_recent
    @responce ||= Nokogiri::XML(open(CURRENT))
    @responce.css("outputValue").text unless @responce.nil?
  end


  def process value
    @res = {}

    value.split("").each_with_index { |sign, i |
      if @res.has_key?(sign)
        @res[sign]+=1
      else
        @res[sign]=1
      end
    }
    return @res
  end

  def print
    @res.each { |key, value|
      puts "#{key.to_s} , #{value.to_s}"
    }
  end
end
