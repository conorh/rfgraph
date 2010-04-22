module RFGraph
  module Objects
    # http://developers.facebook.com/docs/reference/api/group
    class Event < Base
      connections :feed
      connections :members, :type => User
      connections :picture, :type => Photo
    end
  end
end