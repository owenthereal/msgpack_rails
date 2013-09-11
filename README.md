# msgpack_rails [![Build Status](https://travis-ci.org/jingweno/msgpack_rails.png?branch=master)](https://travis-ci.org/jingweno/msgpack_rails)

The Rails way to serialize/deserialize objects with [Message Pack](http://msgpack.org).
It implements the [ActiveSupport](http://rubygems.org/gems/activesupport) [encoder](https://github.com/jingweno/msgpack_rails/blob/master/lib/msgpack_rails/activesupport/message_pack/encoding.rb) & [decoder](https://github.com/jingweno/msgpack_rails/blob/master/lib/msgpack_rails/activesupport/message_pack/decoding.rb) and the [ActiveModel](http://rubygems.org/gems/activemodel) [serializer](https://github.com/jingweno/msgpack_rails/blob/master/lib/msgpack_rails/activemodel/serializers/message_pack.rb) for Message Pack.

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

You can also use it as part of `ActiveModel`, similar to `to_json`:

```ruby
class Contact
  include ActiveModel::Serializers::MessagePack

  ...
end

@contact = Contact.new
@contact.name = 'Owen Ou'
@contact.age = 28
@contact.created_at = Time.utc(2006, 8, 1)
@contact.awesome = true
@contact.preferences = { 'shows' => 'anime' }

@contact.to_msgpack                # => msgpack output
@contact.to_msgpack(:root => true) # => include root in msgpack output
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
