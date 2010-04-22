require 'open-uri'
require 'cgi'

module RFGraph
  class Auth
    attr_accessor :app_id
    attr_accessor :app_secret
    attr_accessor :access_token
    attr_accessor :expires

    def initialize(app_id, app_secret)
      @app_id = app_id
      @app_secret = app_secret
    end

    # Options:
    # * :scope - either a String "user_photos,user_videos,stream_publish" or an
    # Array like [:user_photos, :user_videos, :stream_publish]
    # For more permission scopes, see http://developers.facebook.com/docs/authentication/permissions
    def authorize_url(callback_url, options = {})
      url = "#{BASE_URL}/oauth/authorize?client_id=#{app_id}&redirect_uri=#{callback_url}"
      url += "&scope=#{options[:scope].join(',')}" unless options[:scope].blank?
      return url
    end
    
    # Take the oauth2 request token and turn it into an access token 
    # which can be used to access private data
    def authorize(callback_url, code)
      data = open("#{BASE_URL}/oauth/access_token?client_id=#{app_id}&redirect_uri=#{CGI.escape callback_url}&client_secret=#{app_secret}&code=#{CGI.escape code}").read
      
      # The expiration date is not necessarily set, as the app might have
      # requested offline_access to the data
      match_data = data.match(/expires=([^&]+)/)
      @expires = match_data && match_data[1] || nil
      
      # Extract the access token
      @access_token = data.match(/access_token=([^&]+)/)[1]
    end
  end
end