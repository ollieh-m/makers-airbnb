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