require 'json'
require 'oauth2'

module RFGraph
  class Client
    attr_accessor :access_token

    def initialize(access_token)
      @access_token = if access_token.kind_of?(String)
        OAuth2::AccessToken.new(nil, access_token)
      else
        access_token
      end
    end

    object_types :page, :user, :event, :application, :status_message, :photo, :photo_album, :video, :note

    def self.object_types(args)
      args.each |type| do
        define_method(get_object(:page)
      end
      end
    end

    def get_object(id, args = {})
      parse_response access_token.get(id, args)
    end

    def get_objects(ids, args = {})
      args["ids"] = ids.join(",")
      parse_response access_token.get("", args)
    end

    def get_connections(id, connection_name, args = {})
       parse_response access_token.get(id + "/" + connection_name, args)
    end

    def put_object(parent_object, connection_name, data = {})
      access_token.post(parent_object + "/" + connection_name, data)
    end

    def put_wall_post(message, attachment = {}, profile_id = "me")
      parse_response access_token.post("#{profile_id}/feed", attachment.merge({'message' => message}))
    end

    def put_comment(object_id, message)
      parse_response access_token.post("#{object_id}/comments", {"message" => message})
    end

    def put_like(object_id)
      parse_response access_token.post("#{object_id}/likes")
    end

    # You can delete a like by issuing a DELETE request to /POST_ID/likes (since likes don't have an ID).
    def delete_like(object_id)
      parse_response delete_object("#{object_id}/likes")
    end

    def delete_object(object_id)
      parse_response access_token.delete(object_id)
    end

    def search(query, type)
      get_object("search", :q => query, :type => type)
    end

    def search_news_feed(query, profile_id = "me")
      get_object("#{profile_id}/home", :q => query)
    end

    def search_posts(query)
      search(query, "post")
    end

    def search_people(query)
      search(query, "people")
    end

    def search_pages(query)
      search(query, "page")
    end

    def search_events(query)
      search(query, "event")
    end

    def search_groups(query)
      search(query, "group")
    end

    def parse_response(response)
      response = JSON.parse(response)

      if response["error"]
        raise RFGraphError.new(response["code"], response["message"], response)
      end
    end
  end
end