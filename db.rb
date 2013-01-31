# coding: utf-8

require 'mongoid'

# おすすめindex
# db.topics.ensureIndex( { "starts_at": 1 } )
# db.topics.ensureIndex( { "url": 1 } )

class Topic
  include Mongoid::Document
  include Mongoid::Timestamps

  field :starts_at, type: Time
  field :title, type: String
  field :hashtag, type: String
  field :url, type: String
end

Mongoid.configure do |config|
  config.sessions = { default: { database: 'timetable_bot', hosts: [ 'localhost:27017' ] }}
end

if false
  Mongoid.logger.level = Logger::DEBUG
  Moped.logger.level = Logger::DEBUG
end
