## Developing ##

http://developers.facebook.com/docs/authentication/


`auth = Fbrails::Auth.new(app_id,app_secret,app_url)`

  
`auth.redirect_url # get a redirect page to server-flow authorization`

`token = auth.token(code) # getting token from code which send back from facebook`




`@graph = Fbrails::Graph.new(token)`

`@graph.token_valid? # return true of false`

`@graph.me # return hash with your info or false`
