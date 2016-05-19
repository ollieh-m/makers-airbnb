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

    def validate_date_not_empty(*dates)
      if dates.any? {|date| date.empty?}
        flash.next[:errors] = ['Please put in both the start and end date.']
        redirect "/spaces/mine/#{params[:id]}"
      end
    end

    def validate_date(start,finish)
      if start > finish
        flash.next[:errors] = ['Start date must be before end date']
        redirect "/spaces/mine/#{params[:id]}"
      elsif DateTime.now > start
        flash.next[:errors] = ['That ship has sailed']
        redirect "/spaces/mine/#{params[:id]}"
      end
    end

  end

  get '/' do
    redirect '/spaces'
  end

  #SPACES

  get '/spaces' do
    @spaces = Space.all
    erb :'spaces/index'
  end

  post '/spaces' do
    current_user.spaces.create(params)
    redirect '/spaces'
  end

  get '/spaces/all/:id' do
    @space = Space.get(params[:id])
    erb :'spaces/individual_space'
  end

  get '/spaces/new' do
    erb :'spaces/new'
  end

  get '/spaces/mine' do
    erb :'spaces/myspaces'
  end

  get '/spaces/mine/:id' do
    @space = Space.get(params[:id])
    erb :'spaces/my_individual_space'
  end

  post '/spaces/mine/:id/available_date' do
    validate_date_not_empty(params[:available_date_start],params[:available_date_finish])
    start_day = DateTime.parse(params[:available_date_start])
    finish_day = DateTime.parse(params[:available_date_finish])
    validate_date(start_day,finish_day)

    days = (start_day..finish_day).group_by(&:day).map { |_,day| day }
    space  = Space.get(params[:id])

    days.each do |available_day|
      available_date = AvailableDate.first_or_create(date: available_day)
      unless available_date.spaces.include?(space)
        available_date.spaces << space
        available_date.save
      end
    end
    redirect "/spaces/mine/#{params[:id]}"
  end


  #USERS

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    @user = User.new(name: params[:name],
    email: params[:email], password: params[:password],
    password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :'users/new'
    end
  end

  #BOOKINGS

  get '/requests' do
    @spaces = current_user.spaces
    erb :'requests'
  end

  post '/requests/:space_id' do
    req = BookingRequest.new(date: DateTime.parse(params[:date]),  user: current_user, space: Space.first(id: params[:space_id]))
    boolean = !req.space.available_dates.find_index {|a_date|a_date.date.strftime("%m/%d/%Y")  == req.date.strftime("%m/%d/%Y")}

    if boolean
      flash.next[:errors] = ['The space is not available on that date']
      redirect "/spaces/all/#{params[:space_id]}"
    elsif (req.user.email == req.space.user.email)
      flash.next[:errors] = ['You cannot book your own space']
      redirect '/'
    else
      req.save
      redirect '/'
    end
  end

  post '/requests/confirmation/:booking_id' do
    BookingRequest.first(id: params[:booking_id]).update(status:'Confirmed')
    booking_request = BookingRequest.first(id: params[:booking_id])
    available_date = AvailableDate.first(date: booking_request.date)
    space = booking_request.space
    link = AvailableDateSpace.get(space.id, available_date.id)
    link.destroy
    redirect '/requests'
  end

  post '/requests/rejection/:booking_id' do
    BookingRequest.first(id: params[:booking_id]).update(status: 'Rejected')
    redirect '/requests'
  end

  #SESSIONS

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
