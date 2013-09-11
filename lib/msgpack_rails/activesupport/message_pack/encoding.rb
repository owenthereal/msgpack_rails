require "active_support/json"
require "msgpack_rails/activesupport/core_ext/object/to_msgpack"

module ActiveSupport
  module MessagePack
    def self.encode(value, options = nil)
      as_msgpack_opts, out = if options.is_a?(Hash)
                               [options, nil]
                             else
                               [nil, options]
                             end
      value.as_msgpack(as_msgpack_opts).msgpack_to_msgpack(out)
    end
  end
end

class Object
  def as_msgpack(options = nil)
    as_json(options)
  end
end
