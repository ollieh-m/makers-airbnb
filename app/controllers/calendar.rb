class MakersBnB < Sinatra::Base

	get '/available_dates/:id' do
    headers 'Access-Control-Allow-Origin' => '*'
    space = Space.get(params[:id])
    array = []
    space.available_dates.each do |available_date|
      hash = { date: available_date.date.strftime("%Y-%m-%d"),
        badge: true,
        title: "Available",
        body: "Click here to request a booking on this date",
        footer: "<button id='make-request'>Make request</button>",
        classname: "available-date"
      }
      array.push(hash)
    end
    JSON.generate(array)
  end

end