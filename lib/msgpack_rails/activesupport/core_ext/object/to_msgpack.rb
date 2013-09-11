# Hack to load msgpack gem first so we can overwrite its to_msgpack.

begin
  require "msgpack"
rescue LoadError
end

# The msgpack gem adds a few modules to Ruby core classes containing :to_msgpack definition, overwriting
# their default behavior. That said, we need to define the basic to_msgpack method in all of them,
# otherwise they will always use to_msgpack gem implementation.
[Object, NilClass, TrueClass, FalseClass, Fixnum, Bignum, Float, String, Array, Hash, Symbol].each do |klass|
  klass.class_eval do
    # Dumps object in msgpack. See http://msgpack.org for more info.
    def to_msgpack(options = {})
      ActiveSupport::MessagePack.encode(self, options)
    end
  end
end
