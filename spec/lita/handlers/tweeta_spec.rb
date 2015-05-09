require "spec_helper"

describe Lita::Handlers::Tweeta, lita_handler: true do
  before do
    registry.config.handlers.tweeta.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
    registry.config.handlers.tweeta.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
    registry.config.handlers.tweeta.access_token = ENV["TWITTER_ACCESS_TOKEN"]
    registry.config.handlers.tweeta.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
  end

  it { is_expected.to route("hey jimmy https://twitter.com/tristaneuan/status/463007122087616512 check out this tweet").to(:tweeta) }
  it { is_expected.to route_command("tw SFSiren").to(:user_tweet) }
  it { is_expected.to route_command("tweet SFSiren").to(:user_tweet) }
  it { is_expected.to route_command("twitter SFSiren").to(:user_tweet) }

  describe "#tweeta" do
    it "returns a linked tweet's text, author, and date" do
      send_message "hey jimmy https://twitter.com/tristaneuan/status/463007122087616512 check out this tweet"
      expect(replies.first).to match(/^"Congratulations on 400 GitHub stars, @litachatbot and @jimmycuadra! #chatops #ruby [\S]+" --Tristan Chong, 2014-05-04$/)
    end

    it "does not send a message in response to a Twitter URL containing an invalid status ID" do
      send_message "https://twitter.com/tristaneuan/status/1"
      expect(replies.count).to eq 0
    end
  end

  describe "#user_tweet" do
    it "returns a specified user's latest tweet" do
      send_command "tweet sfsiren"
      expect(replies.first).to match(/^"This is a test\. This is a test of the outdoor warning system\. This is only a test\." --SFSiren, \d{4}-\d{2}-\d{2}$/)
    end

    it "does not send a message in response to an invalid Twitter username" do
      send_command "tweet abcdefghijklmnop"
      expect(replies.count).to eq 0
    end
  end
end
