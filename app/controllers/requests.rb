class MakersBnB < Sinatra::Base

get '/requests' do
  @spaces = current_user.spaces
  @booking_requests = current_user.booking_requests
  erb :'requests'
end

post '/requests/:space_id' do
  if params[:date].empty?
    flash.next[:errors] = ['Please select date']
    redirect "/spaces/all/#{params[:space_id]}"
  end
  request = BookingRequest.new(date: DateTime.parse(params[:date]),  user: current_user, space: Space.get(params[:space_id]))
  if request.space_unavailable?
    flash.next[:errors] = ['The space is not available on that date']
    redirect "/spaces/all/#{params[:space_id]}"
  end
  if request.self_booking?
    flash.next[:errors] = ['You cannot book your own space']
    redirect '/'
  end
  request.save
  redirect '/'
end

post '/requests/confirmation/:booking_id' do
  booking_request = BookingRequest.get(params[:booking_id])
  booking_request.update(status: 'Confirmed')
  remove_confirmed_date(booking_request)
  redirect '/requests'
end

post '/requests/rejection/:booking_id' do
  BookingRequest.first(id: params[:booking_id]).update(status: 'Rejected')
  redirect '/requests'
end

end
