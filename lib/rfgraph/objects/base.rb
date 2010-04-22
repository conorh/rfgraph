class Base
  attr_accessor :data

  def initialize(data)
    @data = data
  end

  def get_connections(type, opts = {})
    @client.get("object_id/#{type}")
  end

  def self.connections(name, opts = {})
    
  end

  def method_missing(method, args)
    if @connections.find(method)
      get_connections(method, args)
    elsif method =~ /time/
      Time.parse(data[method])
    else
      value = data[method] 
      if value =~ /^\d+$/
        value.to_i
      else
        value
      end
    end
  end
end