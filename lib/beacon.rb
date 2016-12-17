require 'nokogiri'
require 'open-uri'
require_relative 'responce_processor'


class Beacon

  attr_accessor :res

  def initialize
    @res={}
  end

  def process value
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
      puts "#{key.to_s}, #{value.to_s}"
    }
  end
end
