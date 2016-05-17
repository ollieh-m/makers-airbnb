ENV['RACK_ENV'] ||= 'development'


require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require_relative 'data_mapper_setup'
require 'time'

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
    if current_user
      redirect '/spaces'
    else
      erb :'users/new'
    end
  end

  get '/spaces' do
    @spaces = Space.all
    erb :'spaces/index'
  end

  post '/spaces' do
    current_user.spaces.create(params)
    redirect '/spaces'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  get '/users/new' do
    erb :'users/new'
  end

  get '/spaces/:id' do
    @space = Space.get(params[:id])
    erb :'spaces/individual_space'
  end

  post '/bookings/:space_id' do
    req = BookingRequest.create(date: DateTime.parse(params[:date]),  user: current_user, space: Space.first(id: params[:space_id]))
    redirect '/'
  end

  get '/bookings/received' do
    @spaces = current_user.spaces
    erb :'bookings/received'
  end

  post '/users' do
    user = User.create(name: params[:name],
    email: params[:email], password: params[:password],
    password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      redirect '/'
    else
      flash.now[:errors] = user.errors.full_messages
      @name = params[:name]
      @email = params[:email]
      erb :'users/new'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/'
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
    flash.keep[:notice] = 'See you next time!'
    redirect '/'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
