# coding: utf-8

require 'pp'
require 'json'
require 'open-uri'

require './parser'
require './db'

data = JSON.parse(open('http://api.atnd.org/events/?count=100&format=json').read)

data['events'].each do |event|
  # 同じイベントが取得済みなら、既存のデータを一旦削除
  Topic.destroy_all(url: event['event_url'])

  table = Parser.parse(event['description'])

  table.each do |e|
    # @todo 日付をまたぐ場合
    date = Time.parse(event['started_at'])
    time = Time.parse(e[0])
    starts_at = Time.new(date.year, date.month, date.day, time.hour, time.min)

    Topic.create({
      starts_at: starts_at,
      title: e[1],
      hashtag: event['hash_tag'],
      url: event['event_url'],
    })
  end
end
