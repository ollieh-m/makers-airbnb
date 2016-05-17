class Space

	include DataMapper::Resource

	property :id, Serial
  property :title, String
  property :location, String
  property :description, Text
  property :price, Integer

  has n, :available_dates, through: Resource
  belongs_to :user
  has n, :booking_requests
  
end
