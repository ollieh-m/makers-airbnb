require_relative 'helpers'

class MakersBnB < Sinatra::Base

	use Rack::MethodOverride
	enable :sessions
	register Sinatra::Flash
	register Sinatra::Partial
	set :session_secret, 'super secret'
	set :partial_template_engine, :erb

	enable :partial_underscores

  helpers Helpers
end