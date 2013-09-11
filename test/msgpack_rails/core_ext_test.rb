require_relative "../test_helper"

class TestMessagePackCoreExt < Test::Unit::TestCase
  def test_to_msgpack
    [nil, true, false, 10, 123456789 ** 2, 1.0, "foo", [:foo, :bar], {:a => :b}, :a, Time.now, /foo/, Date.new, DateTime.new].each do |data|
      assert_equal MessagePack.pack(data.as_json), data.to_msgpack
    end
  end
end
