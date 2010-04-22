require 'rfgraph/client'
require 'rfgraph/objects/base'
require 'rfgraph/objects/album'
require 'rfgraph/objects/event'
require 'rfgraph/objects/group'
require 'rfgraph/objects/link'
require 'rfgraph/objects/note'
require 'rfgraph/objects/page'
require 'rfgraph/objects/photo'
require 'rfgraph/objects/post'
require 'rfgraph/objects/status_message'
require 'rfgraph/objects/user'
require 'rfgraph/objects/video'

module RFGraph
  BASE_URL = "https://graph.facebook.com"

  def self.get_user_from_cookie(cookies, app_id, app_secret)
    # TODO
  end

  class RFGraphError < RuntimeError
    attr_accessor :code
    attr_accessor :json

    def initialize(code, message, json)
      @code = code
      @json = json
      super(message)
    end
  end
end