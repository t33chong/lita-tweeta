require "twitter"

module Lita
  module Handlers
    class Tweeta < Handler
      route(/https:\/\/twitter.com\/\w+\/status\/(\d+)/i, :tweeta,
            command: false)

      def self.default_config(config)
        config.consumer_key = ENV["TWITTER_CONSUMER_KEY"]
        config.consumer_secret = ENV["TWITTER_CONSUMER_SECRET"]
        config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET"]
      end

      def initialize
        @client = Twitter::REST::Client.new do |config|
          config.consumer_key = Lita.config.handlers.tweeta.consumer_key
          config.consumer_secret = Lita.config.handlers.tweeta.consumer_secret
          config.access_token = Lita.config.handlers.tweeta.access_token
          config.access_token_secret = Lita.config.handlers.tweeta.access_token_secret
        end
      end

      def tweeta(response)
        tweet = @client.status(response.matches.first.first.to_i)
        response.reply "#{tweet.user.name} said: #{tweet.text}"
      end
    end

    Lita.register_handler(Tweeta)
  end
end
