require_relative "../test_helper"
require "msgpack_rails/activemodel/serializers/message_pack"
require_relative "models/contact"

class Contact
  include ActiveModel::Serializers::MessagePack
  include ActiveModel::Validations

  def attributes=(hash)
    hash.each do |k, v|
      instance_variable_set("@#{k}", v)
    end
  end

  remove_method :attributes if method_defined?(:attributes)

  def attributes
    instance_values
  end
end

class TestMessagePackSerializer < Minitest::Test
  def setup
    ActiveSupport.parse_msgpack_times = true

    @contact = Contact.new
    @contact.name = 'Konata Izumi'
    @contact.age = 16
    @contact.created_at = Time.utc(2006, 8, 1)
    @contact.awesome = true
    @contact.preferences = { 'shows' => 'anime' }
  end

  def teardown
    # set to the default value
    ActiveSupport.parse_msgpack_times = false
    Contact.include_root_in_msgpack = false
  end

  def test_not_include_root_in_msgpack
    contact = ActiveSupport::MessagePack.decode(@contact.to_msgpack)
    assert_equal @contact.attributes.size, contact.size

    @contact.attributes.each do |k, v|
      assert_equal v, contact[k]
    end
  end

  def test_include_root_in_msgpack
    result = ActiveSupport::MessagePack.decode(@contact.to_msgpack(:root => true))
    assert_equal 1, result.size

    contact = result["contact"]
    @contact.attributes.each do |k, v|
      assert_equal v, contact[k]
    end
  end

  def test_from_msgpack
    ActiveSupport.parse_msgpack_times = false

    msgpack = @contact.to_msgpack(:root => true)
    result = Contact.new.from_msgpack(msgpack, true)

    assert_equal result.name, @contact.name
    assert_equal result.age, @contact.age
    assert_equal Time.parse(result.created_at), @contact.created_at
    assert_equal result.awesome, @contact.awesome
    assert_equal result.preferences, @contact.preferences
  end
end
