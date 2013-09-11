require "active_support"
require "msgpack_rails/version"
require "msgpack_rails/activesupport/message_pack"

module ActiveSupport
  eager_autoload do
    autoload :MessagePack
  end
end
