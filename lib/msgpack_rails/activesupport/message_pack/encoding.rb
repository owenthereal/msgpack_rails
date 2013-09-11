require "active_support/json"
require "msgpack_rails/activesupport/core_ext/object/to_msgpack"

module ActiveSupport
  module MessagePack
    def self.encode(value, options = {})
      out = options.fetch(:out, nil)
      ::MessagePack.pack(value.as_msgpack(options), out)
    end
  end
end

class Object
  def as_msgpack(options = {})
    as_json(options)
  end
end
