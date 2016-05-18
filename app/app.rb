ENV['RACK_ENV'] ||= 'development'


require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require_relative 'data_mapper_setup'
require 'time'
require 'date'

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

  get '/users/spaces' do
    erb :'users/my_spaces'
  end

  get '/users/spaces/:space_id' do
    @space = Space.get(params[:space_id])
    erb :'users/my_individual_space'
  end

  post '/users/available_date/:space_id' do
    if params[:available_date_start] == "" || params[:available_date_finish] == ""
      flash.next[:errors] = ['Please select both start and finish dates']
      redirect "/users/spaces/#{params[:space_id]}"
    else

    start_day = DateTime.parse(params[:available_date_start])
    finish_day = DateTime.parse(params[:available_date_finish])

    if start_day > finish_day
      flash.next[:errors] = ['Start date must be before end date']
      redirect "/users/spaces/#{params[:space_id]}"
    elsif DateTime.now > start_day
      flash.next[:errors] = ['That ship has sailed']
      redirect "/users/spaces/#{params[:space_id]}"
    else

      days = (start_day..finish_day).group_by(&:day).map { |_,day| day }
      space  = Space.get(params[:space_id])

      days.each do |available_day|
        available_date = AvailableDate.first_or_create(date: available_day)
        unless available_date.spaces.include?(space)
          available_date.spaces << space
          available_date.save
        end
      end
      redirect "/users/spaces/#{params[:space_id]}"
    end
  end
end
  post '/bookings/:space_id' do
    req = BookingRequest.new(date: DateTime.parse(params[:date]),  user: current_user, space: Space.first(id: params[:space_id]))
    if req.user.email == req.space.user.email
      flash.next[:errors] = ['You cannot book your own space!']
    else
      req.save
    end
    redirect '/'
  end
  #ideally we want to validate in the models but boy did shit hit the fan when we attempted that

  get '/bookings/received' do
    @spaces = current_user.spaces
    erb :'bookings/received'
  end

  post '/bookings/confirmation/:booking_id' do
    BookingRequest.first(id: params[:booking_id]).update(status:'Confirmed')
    booking_request = BookingRequest.first(id: params[:booking_id])
    available_date = AvailableDate.first(date: booking_request.date)
    space = booking_request.space
    link = AvailableDateSpace.get(space.id, available_date.id)
    link.destroy
    redirect 'bookings/received'
  end

  post '/bookings/rejection/:booking_id' do
    BookingRequest.first(id: params[:booking_id]).update(status: 'Rejected')
    redirect 'bookings/received'
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
