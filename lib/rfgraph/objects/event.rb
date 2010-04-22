module RFGraph
  module Objects
    # http://developers.facebook.com/docs/reference/api/event
    class Event < Base
      connections :feed
      connections :noreply, :type => User
      connections :maybe, :type => User
      connections :invited, :type => User
      connections :attending, :type => User
      connections :declined, :type => User
      connections :picture, :type => Photo
    end
  end
end