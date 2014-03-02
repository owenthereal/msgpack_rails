require "active_support"
require "msgpack_rails/version"
require "msgpack_rails/activesupport/message_pack"

module ActiveSupport
  eager_autoload do
    autoload :MessagePack
  end
end

if defined?(ActiveModel)
  require "msgpack_rails/activemodel/serializers/message_pack"

  module ActiveModel
    module Serializers
      eager_autoload do
        autoload :MessagePack
      end
    end
  end
end

if defined?(::Rails)
  module MsgpackRails
    class Rails < ::Rails::Engine
      initializer "msgpack_rails" do
        ::ActiveRecord::Base.send(:include, ActiveModel::Serializers::MessagePack)

        # Add a msgpack MIME type
        Mime::Type.register "application/msgpack", :msgpack

        # Register :msgpack as a renderer.
        # Note that the options are currently only passed to the `as_json`
        # call. This may not be the desired behaviour.
        ActionController::Renderers.add :msgpack do |data, options|
          data = data.as_json(options)

          self.content_type ||= Mime::MSGPACK
          self.response_body = data.to_msgpack()
        end
      end
    end
  end
end
