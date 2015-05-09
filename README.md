# lita-tweeta

**lita-tweeta** is a handler for [Lita](https://github.com/jimmycuadra/lita) that displays a tweet for a given Twitter URL or username.

## Installation

Add lita-tweeta to your Lita instance's Gemfile:

``` ruby
gem "lita-tweeta"
```

## Configuration

Twitter's API requires authentication via OAuth, so you'll need to [register your application with Twitter](https://apps.twitter.com/).

``` ruby
Lita.configure do |config|
  config.handlers.tweeta.consumer_key = "foo"
  config.handlers.tweeta.consumer_secret = "bar"
  config.handlers.tweeta.access_token = "baz"
  config.handlers.tweeta.access_token_secret = "luhrmann"
end
```

## Usage

To have Lita display a tweet, simply paste its URL into the chat channel:

```
<me> congratulations jimmy https://twitter.com/tristaneuan/status/463007122087616512
<lita> "Congratulations on 400 GitHub stars, @litachatbot and @jimmycuadra! #chatops #ruby https://t.co/mADTTu3M3N" --Tristan Chong, 2014-05-04
```

You can also retrieve a given user's latest tweet:

```
<me> @lita: tweet sfsiren
<lita> "This is a test. This is a test of the outdoor warning system. This is only a test." --SFSiren, 2015-05-05
```

## License

[MIT](http://opensource.org/licenses/MIT)
