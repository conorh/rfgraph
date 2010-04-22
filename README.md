Ruby Facebook Graph API Wrapper
===============================

A simple Ruby wrapper to help use the Facebook Graph API.

Documentation on the Graph API is available here:
http://developers.facebook.com/docs/

Install
-------

gem install rfgraph

Example
-------

    require 'rfgraph'
    fauth = RFGraph::Auth.new(APP_ID, APP_SECRET)

    # Get the URL to redirect your user to in their web browser
    auth_url = fauth.authorize_url("http://yourwebsite.com/callback")

    # Get the code that facebook returns after the user auths your app and turn that into a auth token
    auth_token = fauth.authorize("http://yourwebsite.com/callback", FACEBOOK_CODE)

    # Make some requests
    request = RFGraph::Request.new(auth_token)
    request.get_object("me")

    # Returns something like
    #{
    #   "id" => "57373737593",
    #   "name" => "Some User",
    #   "first_name" => "Some",
    #   "last_name" => "User",
    #   "link" => "http://www.facebook.com/someuser",
    #   "timezone" =>  -4,
    #   "verified" => true,
    #   "updated_time" => "2010-03-30T01:27:19+0000"
    # }

    request.put_wall_post("Awesome message!")

COPYRIGHT
---------

Copyright (c) 2010 Conor Hunt <conor.hunt@gmail.com>
Released under the MIT license