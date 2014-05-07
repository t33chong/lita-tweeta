require "twitter"

module Lita
  module Handlers
    class Tweeta < Handler
      route(/https:\/\/twitter.com\/\w+\/status\/(\d+)/i, :tweeta,
            command: false)

      def self.default_config(config)
      end

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
        tweet = @client.status(response.matches.first.first.to_i)
        response.reply "#{tweet.user.name} said: #{tweet.text}"
      end
    end

    Lita.register_handler(Tweeta)
  end
end
