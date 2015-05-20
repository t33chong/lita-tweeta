require "date"
require "twitter"

module Lita
  module Handlers
    class Tweeta < Handler
      config :consumer_key, type: String, required: true
      config :consumer_secret, type: String, required: true
      config :access_token, type: String, required: true
      config :access_token_secret, type: String, required: true

      route(/https:\/\/twitter\.com\/\w+\/status\/(\d+)/i, :tweeta,
            command: false)
      route(/^tw(?:eet|itter)?\s+(\w+)/i, :user_tweet, command: true,
            help: {t("help.tweeta_key") => t("help.tweeta_value")})

      def initialize(robot)
        super
        @client = Twitter::REST::Client.new do |config|
          config.consumer_key = Lita.config.handlers.tweeta.consumer_key
          config.consumer_secret = Lita.config.handlers.tweeta.consumer_secret
          config.access_token = Lita.config.handlers.tweeta.access_token
          config.access_token_secret = Lita.config.handlers.tweeta.access_token_secret
        end
      end

      def tweeta(response)
        begin
          tweet = @client.status(response.matches.first.first.to_i)
        rescue Twitter::Error::NotFound
          return
        else
          response.reply format(tweet)
        end
      end

      def user_tweet(response)
        username = response.matches.first.first
        if @client.user?(username)
          user = @client.user(username)
          tweets = @client.user_timeline(user, {count: 1, include_rts: false})
          unless tweets.empty?
            response.reply format(tweets.first)
          end
        end
      end

      private
      def format(tweet)
        "\"#{tweet.text}\" --#{tweet.user.name}, #{tweet.created_at.strftime('%F')}"
      end
    end

    Lita.register_handler(Tweeta)
  end
end
