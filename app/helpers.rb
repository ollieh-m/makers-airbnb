module Helpers

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