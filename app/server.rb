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

    def validate_date_time(start,finish)
      if start > finish
        flash.next[:errors] = ['Start date must be before end date']
        redirect "/spaces/mine/#{params[:id]}"
      elsif DateTime.now > start
        flash.next[:errors] = ['That ship has sailed']
        redirect "/spaces/mine/#{params[:id]}"
      end
    end

    def remove_confirmed_date(request)
      available_date = AvailableDate.first(date: request.date)
      space = request.space
      link = AvailableDateSpace.get(space.id, available_date.id)
      link.destroy
    end

    def add_available_days(days,space)
      days.each do |available_day|
        available_date = AvailableDate.first_or_create(date: available_day)
        AvailableDateSpace.first_or_create(available_date: available_date, space: space)
      end
    end

  end

end