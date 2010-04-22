require 'json'
require 'oauth2'

module RFGraph
  class Analytics
    attr_accessor :access_token

    def initialize(access_token)
      @access_token = access_token
    end
    
    def insights
      parse_response access_token.get("")
    end
  end
end