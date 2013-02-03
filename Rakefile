require 'rspec/core/rake_task'

require './db'
require './tweet'

RSpec::Core::RakeTask.new do |task|
  task.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
  task.pattern    = 'spec/**/*_spec.rb'
end

class Time
  def self.today
    now = Time.now
    Time.new(now.year, now.month, now.day)
  end
end

task :schedule do
  topics = Topic
    .where(:starts_at.gte => Time.today)
    .where(:starts_at.lte => Time.today + 2 * 24 * 3600)
    .order_by([:starts_at, :asc])

  tweets = topics.map{|e| Tweet.to_tweet(e.attributes) }
  puts tweets.join("\n")
end
