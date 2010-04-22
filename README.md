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

    # Get the user's profile
    client.get_object("me")
    
    # Paginate through your wall posts
    client.get_object("me/feed")
    
    # Get all your wall posts since yesterday
    client.get_object("me/feed", {:since => "yesterday"})
    
    # Get all your wall posts before 6:30pm today
    client.get_object("me/feed", {:before => })
    
    
    # Get another user's profile, but limit the fields returned
    client.get_object("bgolub", {:fields => "id,name,picture"})

    # Place a wall post on the auth'd user's wall
    client.put_wall_post("Awesome message!")

    # Plase a wall most with metadata on the auth'd user's wall
    client.put_wall_post(message, {:picture => "", :link => "", :name => "", :description => ""})

    # Place a wall post on another user's wall
    client.put_wall_post(message, {}, 'arjun')

    client.get_objects(['arjun','vernal'])
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