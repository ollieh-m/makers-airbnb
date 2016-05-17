class AvailableDate

  include DataMapper::Resource

  property :id,   Serial
  property :date, DateTime, required: true

  has n, :spaces, through: Resource
  
end
