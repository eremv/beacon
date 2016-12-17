require_relative '../lib/beacon'
require_relative '../lib/date_converter'
require_relative '../lib/responce_processor'
require 'optparse'
require 'pry'
require 'active_support/all'

options = {}
responce_processor = ResponceProcessor.new
beacon = Beacon.new


  OptionParser.new do |opt|
    opt.on('--from BEGIN') { |o| options[:begin] = o }
    opt.on('--to END') { |o| options[:end] = o }
  end.parse!



if options!= {}
  outputs = responce_processor.get_for_period(options[:begin], options[:end])
  outputs.each do |o|
    beacon.process o
  end
  beacon.print
else
  beacon.process responce_processor.get_recent
  beacon.print
end



