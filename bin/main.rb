require_relative '../lib/beacon'
require 'pry'

b = Beacon.new
s = b.get_recent
b.process s
b.print
