# Capobvious

capobvious is a recipes, which i use every day

## Installation

Add this line to your application's Gemfile:

    gem 'fbrails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fbrails

## Usage


http://developers.facebook.com/docs/authentication/


```ruby
auth = Fbrails::Auth.new(app_id,app_secret,app_url)
  
auth.redirect_url # get a redirect page to server-flow authorization
auth.redirect_url(:user_birthday,:read_stream) # with permissions list

token = auth.token(code) # getting token from code which send back from facebook
# => {:token => "TOKEN", :expires => "TIME_WHEN_EXPIRES"}

Fbrails::Auth.token_valid?(token) # return true of false

Fbrails::Auth.token_valid?(token,expire_time) # return true of false



graph = Fbrails::Graph.new(token)

graph.me # return hash with your info or false
```


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
