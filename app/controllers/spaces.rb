class MakersBnB < Sinatra::Base

get '/' do
  redirect '/spaces'
end

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
  validation = AvailableDate.validate(params[:available_date_start],params[:available_date_finish])
  if validation == "pass"
    days_array = AvailableDate.days_to_array(params[:available_date_start],params[:available_date_finish])
    space = Space.get(params[:id])
    add_available_days(days_array,space)
  else
    flash.next[:errors] = validation 
  end
  redirect "/spaces/mine/#{params[:id]}"
end

end