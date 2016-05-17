class BookingRequest

  include DataMapper::Resource

  property :id,     Serial
  property :date,   DateTime, required: true
  property :status, String, default: 'Pending'

  belongs_to :user
  belongs_to :space
  
end
