require "optparse"
require "json"
require "twitter"

opts = {}
OptionParser.new do |opt|
  opt.on("-d", "--delay DELAY", "This is the delay in seconds before each tweet") do |o|
    opts[:delay] = o
  end
  opt.on("-c", "--content CONTENT", "JSON file path (contains token and array of tweets)") do |o|
    opts[:content] = o
  end
end.parse!
unless opts[:delay] && opts[:content]
  $stderr.puts "Error: you must specify both the --delay and --content options."
  exit 1
end
content_file = File.read(opts[:content])
content = JSON.parse(tweetData)
client = Twitter::REST::Client.new do |config|
  config.consumer_key = tweetData["config"]["consumer_key"]
  config.consumer_secret = tweetData["config"]["consumer_secret"]
  config.access_token = tweetData["config"]["access_token"]
  config.access_token_secret = tweetData["config"]["access_token_secret"]
end
content["tweets"].each do |tweet|
  sleep opts[:delay].to_i
  client.update(tweet)
end
puts "Made by Aniol Vicens Lloret"
end
