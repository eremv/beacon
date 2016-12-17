require_relative '../lib/beacon'
require_relative '../lib/date_converter'
require 'optparse'
require 'pry'
require 'active_support/all'

options = {}


  OptionParser.new do |opt|
    opt.on('--from BEGIN') { |o| options[:begin] = o }
    opt.on('--to END') { |o| options[:end] = o }
  end.parse!


b = Beacon.new
s = b.get_recent
b.process s
b.print




binding.pry

converter = DateConverter.new

puts options

puts converter.convert_date options[:begin]
puts converter.convert_date options[:end]


