require "active_support"
require "msgpack_rails/version"

module ActiveSupport
  eager_autoload do
    autoload :MessagePack, "msgpack_rails/activesupport/message_pack"
  end
end

if defined?(ActiveModel)
  module ActiveModel
    module Serializers
      eager_autoload do
        autoload :MessagePack, "msgpack_rails/activemodel/serializers/message_pack"
      end
    end
  end
end

if defined?(::Rails)
  module MsgpackRails
    class Rails < ::Rails::Engine
      initializer "msgpack_rails" do
        if defined?(::ActiveRecord::Base)
          ::ActiveSupport.on_load(:active_record) do
            ::ActiveRecord::Base.send(:include, ActiveModel::Serializers::MessagePack)
          end
        end

        if defined?(::Mongoid::Document)
          ::ActiveSupport.on_load(:mongoid) do
            ::Mongoid::Document.send(:include, ActiveModel::Serializers::MessagePack)
          end
        end

        ::Mime::Type.register "application/msgpack", :msgpack

        if ::Rails::VERSION::MAJOR > 3 || ::Rails::VERSION::MINOR > 0
          ::ActionController::Renderers.add :msgpack do |data, options|
            self.content_type = Mime[:msgpack]
            data.is_a?(String) ? data : data.to_msgpack(options)
          end
        else
          ::ActionController::Renderers.add :msgpack do |data, options|
            self.content_type = Mime[:msgpack]
            self.response_body = data.is_a?(String) ? data : data.to_msgpack(options)
          end
        end

        parameter_parser = ->(raw_data) {
          data = ActiveSupport::MessagePack.decode(raw_data)
          data.is_a?(Hash) ? data : { _msgpack: data }
        }
        if ::Rails::VERSION::MAJOR >= 5
          ActionDispatch::Request.parameter_parsers[Mime[:msgpack].symbol] = parameter_parser
        else
          ActionDispatch::ParamsParser::DEFAULT_PARSERS[Mime[:msgpack]] = parameter_parser
        end
      end
    end
  end
end
