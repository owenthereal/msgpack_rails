require "active_support"
require "active_model"
require "msgpack_rails/version"
require "msgpack_rails/activesupport/message_pack"
require "msgpack_rails/activemodel/serializers/message_pack"

module ActiveSupport
  eager_autoload do
    autoload :MessagePack
  end
end

module ActiveModel
  module Serializers
    eager_autoload do
      autoload :MessagePack
    end
  end
end

module MsgpackRails
  class Rails < ::Rails::Engine
    initializer "msgpack_rails" do
      ::ActiveRecord::Base.send(:include, ActiveModel::Serializers::MessagePack)
    end
  end
end
