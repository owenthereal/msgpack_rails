# Hack to load msgpack gem first so we can overwrite its to_msgpack.

begin
  require "msgpack"
rescue LoadError
end

# The msgpack gem adds a few modules to Ruby core classes containing :to_msgpack definition, overwriting
# their default behavior. That said, we need to define the basic to_msgpack method in all of them,
# otherwise they will always use to_msgpack gem implementation.
klasses = [Object, NilClass, TrueClass, FalseClass, Float, String, Array, Hash, Symbol]
if 1.class.name == "Integer"
  klasses.push(Integer)
else
  klasses.push(Fixnum, Bignum)
end
klasses.each do |klass|
  klass.class_eval do
    alias_method :msgpack_to_msgpack, :to_msgpack if respond_to?(:to_msgpack)
    # Dumps object in msgpack. See http://msgpack.org for more infoa
    def to_msgpack(options = nil)
      ActiveSupport::MessagePack.encode(self, options)
    end
  end
end
