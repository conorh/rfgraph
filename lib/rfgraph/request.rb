require 'json'
require 'net/http'
require 'net/https'

module RFGraph
  class Request
    attr_accessor :access_token

    def initialize(access_token = nil)
      @access_token = access_token
    end

    def get_object(id, args = {})
      request(id, args)
    end

    def get_objects(ids, args = {})
      args["ids"] = ids.join(",")
      return request("", args)
    end

    def get_connections(id, connection_name, args = {})
      return request(id + "/" + connection_name, args)
    end

    def put_object(parent_object, connection_name, data = {})
      raise RFGraphError.new(-1, "Access token required for put requests") if access_token.nil?
      post_request(parent_object + "/" + connection_name, data)
    end

    def put_wall_post(message, attachment = {}, profile_id = "me")
      put_object(profile_id, "feed", attachment.merge({'message' => message}))
    end

    def put_comment(object_id, message)
      put_object(object_id, "comments", {"message" => message})
    end

    def put_like(object_id)
      put_object(object_id, "likes")
    end

    def delete_object(id)
      post_request(id, {"method"=> "delete"})
    end

    def post_request(path, post_args = {})
      request(path, {}, post_args)
    end

    def request(path, url_args = {}, post_args = nil)
      if access_token
        if post_args
          post_args["access_token"] = access_token
        else
          url_args["access_token"] = access_token
        end
      end

      encoded_url_args = url_args.collect {|k,v| "#{CGI.escape k}=#{CGI.escape v}" }.join("&")
      url = URI.parse("#{BASE_URL}/#{path}?#{encoded_url_args}")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      response = if post_args
        encoded_post_args = post_args.collect {|k,v| "#{CGI.escape k}=#{CGI.escape v}" }.join("&")
        http.post("#{url.path}?#{url.query}", encoded_post_args)
      else
        http.get("#{url.path}?#{url.query}")
      end

      response = JSON.parse(response.body)

      if response["error"]
        raise RFGraphError.new(response["error"]["code"], response["error"]["message"])
      end

      response
    end
  end
end