require "msgpack_rails/activesupport/message_pack"

module ActiveModel
  module Serializers
    module MessagePack
      extend ActiveSupport::Concern
      include ActiveModel::Serialization

      included do
        extend ActiveModel::Naming

        class_attribute :include_root_in_msgpack
        self.include_root_in_msgpack = false
      end

      def as_msgpack(options = {})
        root = if options && options.key?(:root)
                 options[:root]
               else
                 include_root_in_msgpack
               end

        if root
          root = self.class.model_name.element if root == true
          { root => serializable_hash(options) }
        else
          serializable_hash(options)
        end
      end

      def from_msgpack(msgpack, include_root=include_root_in_msgpack)
        hash = ActiveSupport::MessagePack.decode(msgpack)
        hash = hash.values.first if include_root
        self.attributes = hash
        self
      end
    end
  end
end
