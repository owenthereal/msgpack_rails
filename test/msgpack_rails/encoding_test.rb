require_relative "../test_helper"

class TestMessagePackEncoding < Minitest::Test
  def test_default_encoding
    [nil, true, false, 10, 123456789 ** 2, 1.0, "foo", [:foo, :bar], {:a => :b}, :a].each do |data|
      assert_equal MessagePack.pack(data), ActiveSupport::MessagePack.encode(data)
    end
  end

  def test_extension_encoding
    [Time.now, /foo/, Date.new, DateTime.new].each do |data|
      assert_equal MessagePack.pack(data.as_json), ActiveSupport::MessagePack.encode(data)
    end
  end
end
