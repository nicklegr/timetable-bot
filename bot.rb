# coding: utf-8

require 'pp'
require 'twitter'
require 'yaml'
require './db'
require './tweet'

settings = YAML.load_file('config.yaml')

Twitter.configure do |config|
  config.consumer_key = settings['consumer_key']
  config.consumer_secret = settings['consumer_secret']
  config.oauth_token = settings['oauth_token']
  config.oauth_token_secret = settings['oauth_token_secret']
end

tweets = Tweet.generate
# tweets = Topic.all.map{ |e| Tweet.to_tweet(e.attributes) }
# pp tweets

tweets.each do |tweet|
  Twitter.update(tweet)
  sleep(2)
end
