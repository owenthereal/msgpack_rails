# msgpack_rails

The Rails way to serialize/deserialize with [Message Pack](http://msgpack.org).
It implements an [ActiveSupport](http://rubygems.org/gems/activesupport) adapter and an [ActiveModel](http://rubygems.org/gems/activemodel) adapter for Message Pack.

## Installation

Add this line to your application's Gemfile:

    gem 'msgpack_rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install msgpack_rails

## Usage

`msgpack_rails` converts data type using `as_json` before feeding it into [msgpack](http://rubygems.org/gems/msgpack).
Here are a few examples:

    $ ActiveSupport::MessagePack.encode(:a => :b)
    => "\x81\xA1a\xA1b"

    $ ActiveSupport::MessagePack.encode(Time.now)
    => "\xB92013-09-11T10:40:39-07:00"

    $ Time.now.as_msgpack
    => "2013-09-11T10:48:13-07:00"

    $ Time.now.to_msgpack
    => "\xB92013-09-11T10:40:39-07:00"

    $ ActiveSupport::MessagePack.decode Time.now.to_msgpack
    => "2013-09-11T11:23:07-07:00"

    # After setting ActiveSupport.parse_msgpack_times to true
    $ ActiveSupport::MessagePack.decode Time.now.to_msgpack
    => Wed, 11 Sep 2013 11:25:18 -0700

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
