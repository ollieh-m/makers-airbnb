ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require_relative 'models/user'
require_relative 'data_mapper_setup'

class MakersBnB < Sinatra::Base

  use Rack::MethodOverride
  enable :sessions
  register Sinatra::Flash
  register Sinatra::Partial
  set :session_secret, 'super secret'
  set :partial_template_engine, :erb

  enable :partial_underscores

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    erb :'listings/all'
  end

  get '/sign_up' do
    erb :'users/sign_up'
  end

  post '/users' do
    user = User.create(name: params[:name],
                      email: params[:email], password: params[:password],
                      password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      redirect '/listings'
    else
      flash.now[:errors] = user.errors.full_messages
      @name = params[:name]
      @email = params[:email]
      erb :'users/sign_up'
    end
  end

  get '/listings' do
    erb :'listings/all'
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/listings'
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
    flash.keep[:notice] = 'See you next time!'
    redirect '/listings'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
