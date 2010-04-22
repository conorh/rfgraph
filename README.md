Ruby Facebook Graph API Wrapper
===============================

A simple Ruby wrapper to help use the Facebook Graph API.

Documentation for the Graph API is available here - 
http://developers.facebook.com/docs/

The first version of this library had OAuth 2.0 helpers, but it now uses the kickass OAuth 2.0 gem. 

Install
-------

gem install rfgraph

Example
-------

    # Create a valid OAuth2 access_token token (see http://github.com/intridea/oauth2)
    OAuth2::Client.new('api_key', 'api_secret', :site => 'https://graph.facebook.com')
    ...
    access_token = client.web_server.access_token(params[:code], :redirect_uri => redirect_uri)

    # Make some requests
    client = RFGraph::Client.new(access_token)
    client.get_object("me")
    client.put_wall_post("Awesome message!")
    client.put_wall_post(message, {}, obj)
    client.get_objects([1,2,3])
    client.get_connections(obj, "friends")
    client.put_comment(obj, message)
    client.put_like(obj)
    client.delete_object(obj)

ATTRIBUTIONS
------------

Patches:
[joost](http://github.com/joost)
[namxam](http://github.com/namxam)

This first version of this code was based off of the Python SDK:
[http://github.com/facebook/python-sdk/](http://github.com/facebook/python-sdk/)

COPYRIGHT
---------

Copyright (c) 2010 Conor Hunt <conor.hunt@gmail.com>
Released under the MIT license