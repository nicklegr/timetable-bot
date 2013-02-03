# coding: utf-8

require 'pp'
require './db'

class Tweet
  TWEET_MAX_LEN = 140
  URL_LEN = 20 + 2 # t.coの現在の長さ+マージン

  def self.generate
    topics = Topic
      .where(:starts_at.gte => Time.now - 60)
      .where(:starts_at.lte => Time.now + 60)

    topics.map{|e| to_tweet(e.attributes) }
  end

  def self.to_tweet(topic)
    starts_at = topic['starts_at'].getlocal.strftime('%-H:%M')
    title = topic['title'].gsub(/[　 ]+/, ' ')
    hashtag = topic['hashtag'].empty? ? '' : '#' + topic['hashtag']
    url = topic['url']

    # 140文字超えたらタイトルカット
    test_len = "■ ----- #{starts_at} #{title} #{hashtag}".strip.size + URL_LEN + 1
    if test_len > TWEET_MAX_LEN
      # @todo title内のURLやらユーザー名が途中で切れることがある
      # それらは「一単語」として考え、単語の途中で切れる場合は単語ごと消す感じでいいかな
      title = title.slice(0, title.size - (test_len - TWEET_MAX_LEN))
    end

    "■ ----- #{starts_at} #{title} #{url} #{hashtag}"
  end
end
