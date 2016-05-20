class BookingRequest

  include DataMapper::Resource

  property :id,     Serial
  property :date,   DateTime, required: true
  property :status, String, default: 'Pending'

  belongs_to :user
  belongs_to :space

	def formatted_date
		date.strftime("%Y-%m-%d")
	end

  def space_unavailable?
    !self.space.available_dates.any?{|a_date|a_date.date == self.date}
  end

  def self_booking?
    self.user == self.space.user
  end

end
