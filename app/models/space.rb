class Space

	include DataMapper::Resource

	property :id, Serial
  property :title, String
  property :location, String
  property :description, Text
  property :price, Integer
  
end
