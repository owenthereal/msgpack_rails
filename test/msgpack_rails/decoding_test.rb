require_relative "../test_helper"

class TestMessagePackEncoding < Minitest::Test
  def test_decoding
    [Time.now, [Date.new], {:foo => DateTime.new}].each do |data|
      assert_equal data.as_json, ActiveSupport::MessagePack.decode(ActiveSupport::MessagePack.encode(data))
    end

    ActiveSupport.parse_msgpack_times = true

    date = DateTime.parse(DateTime.now.as_json)

    test_data = date
    assert_equal test_data, ActiveSupport::MessagePack.decode(ActiveSupport::MessagePack.encode(test_data))

    test_data = [date]
    assert_equal test_data, ActiveSupport::MessagePack.decode(ActiveSupport::MessagePack.encode(test_data))

    test_data = { "foo" => date }
    assert_equal test_data, ActiveSupport::MessagePack.decode(ActiveSupport::MessagePack.encode(test_data))
  end
end
