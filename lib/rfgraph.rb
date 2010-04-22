require 'rfgraph/request'
require 'rfgraph/auth'

module RFGraph
  BASE_URL = "https://graph.facebook.com"

  def self.get_user_from_cookie(cookies, app_id, app_secret)
    # TODO
  end

  class RFGraphError < RuntimeError
    attr_accessor :code

    def initialize(code, message)
      @code = code
      super(message)
    end
  end
end