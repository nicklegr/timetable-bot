# coding: utf-8

require 'pp'
require 'json'
require 'open-uri'

require './parser'

data = JSON.parse(open('http://api.atnd.org/events/?count=100&format=json').read)

data['events'].each do |event|
  table = Parser.parse(event['description'])
  pp table
  # puts event['description']
end

pp data
