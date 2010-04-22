module RFGraph
  module Objects
    # http://developers.facebook.com/docs/reference/api/album
    class Album < Base
      connections :photos, :type => Photo
      connections :comments, :type => Comment
    end
  end
end