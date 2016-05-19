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
  validate_date_not_empty(params[:available_date_start],params[:available_date_finish])
  start_day = DateTime.parse(params[:available_date_start])
  finish_day = DateTime.parse(params[:available_date_finish])
  validate_date_time(start_day,finish_day)
  days = (start_day..finish_day).group_by(&:day).map { |_,day| day }
  space  = Space.get(params[:id])
  add_available_days(days,space)
  redirect "/spaces/mine/#{params[:id]}"
end

end