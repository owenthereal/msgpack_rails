module ActiveSupport
  mattr_accessor :parse_msgpack_times

  module MessagePack
    def self.decode(data)
      data = ::MessagePack.unpack(data)
      if ActiveSupport.parse_msgpack_times
        ActiveSupport::JSON.send(:convert_dates_from, data)
      else
        data
      end
    end
  end
end
