class AvailableDate

  include DataMapper::Resource

  property :id,   Serial
  property :data, DateTime, required: true

  has n, :spaces, through: Resource
  
end
