Ruby Facebook Graph API Wrapper
===============================

A simple Ruby wrapper to help use the Facebook Graph API.

Documentation on the Graph API is available here:
http://developers.facebook.com/docs/

This code is based off of the Python SDK - http://github.com/facebook/python-sdk/

Install
-------

gem install rfgraph

Example
-------

Without auth token

    require 'rfgraph'
    req = RFGraph::Request.new
    req.get_object("19292868552")
    req.get_object("99394368305/photos")
    req.get_object("331218348435", :metadata => 1)

With auth token

    require 'rfgraph'
    fauth = RFGraph::Auth.new(APP_ID, APP_SECRET)

    # Get the URL to redirect your user to in their web browser
    auth_url = fauth.authorize_url("http://yourwebsite.com/callback")

    # Get the code that facebook returns after the user auths your app and turn that into a auth token
    auth_token = fauth.authorize("http://yourwebsite.com/callback", FACEBOOK_CODE)

    # Make some requests using the auth token
    request = RFGraph::Request.new(auth_token)
    request.get_object("me")
    request.get_object("me/friends")

    request.put_wall_post("Awesome message!")

COPYRIGHT
---------

Copyright (c) 2010 Conor Hunt <conor.hunt@gmail.com>
Released under the MIT license