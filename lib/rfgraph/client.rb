require 'json'
require 'oauth2'

module RFGraph
  class Client
    attr_accessor :access_token

    def initialize(access_token)
      @access_token = access_token
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
      parse_response access_token.post("#{object_id}/likes", {"message" => message})
    end

    def delete_object(object_id)
      parse_response access_token.post(object_id, {"message" => message})
    end

    def parse_response(response)
      response = JSON.parse(response)

      if response["error"]
        raise RFGraphError.new(response["code"], response["message"], response)
      end
    end
  end
end