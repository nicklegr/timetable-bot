# coding: utf-8

require 'open-uri'
require 'json'
require 'pp'
require './parser'

url = "http://api.atnd.org/events/?ymd=20130202&count=100&format=json"
json = open(url).read
events = JSON.parse(json)['events']

events.each do |e|
  pp Parser.parse(e['description'])
  puts e['description']
end
