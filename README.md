# MobileSubscriber Gem

It's a fact that the Mobile network providers (carriers, operators & such) share
subscriber identity data to approved 3rd parties when users navigate via Web to
the 3rd parties' websites.

The problem is that generally the algorythms used by these 3rd parties offer
no security against forged HTTP requests.

The goals of this project are basically to detect the user's identity for the
3rd parties, in the most secure and reliably as possible:
- Validate the mobile user's identity by checking the originating IP address
- Validate the request hopping between relaying proxies

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mobile-subscriber'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mobile-subscriber

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/vovimayhem/mobile-subscriber-gem/fork )
2. Clone it (`git clone http://github.com/[your-username]/mobile-subscriber-gem.git`)
3. Create your feature branch (`git checkout -b feature/my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin feature/my-new-feature`)
6. Create a new Pull Request

## References
- [MSISDN - Wikipedia, the free encyclopedia](http://en.wikipedia.org/wiki/MSISDN)
- [Mobile country code - Wikipedia, the free encyclopedia](http://en.wikipedia.org/wiki/Mobile_country_code)
- [Mobile networks: exploiting HTTP headers and data traffic - DefCamp 2012](http://www.slideshare.net/DefCamp/mobile-networks-exploiting-http-headers-and-data-traffic)
- [Privacy Leaks in Mobile Phone Internet Access - Collin Mulliner](http://www.mulliner.org/collin/academic/publications/mobile_web_privacy_icin10_mulliner.pdf)
