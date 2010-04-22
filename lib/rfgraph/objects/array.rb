class Array < Base
  attr_accessor :data
  attr_accessor :next_url
  attr_accessor :previous_url

  def initialize(data, type)
    data["data"].each do |entry|
      type.new(entry)
    end

    if data["paging"]
      @previous_url = json["paging"]["previous"] if json["paging"]["previous"]
      @next_url = json["paging"]["next"] if json["paging"]["next"]
    end
  end

  def get_next
    @client.get(next_url)
  end

  def get_previous
    @client.get(previous_url)
  end
end