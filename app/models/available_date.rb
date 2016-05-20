class AvailableDate

  include DataMapper::Resource

  property :id,   Serial
  property :date, DateTime, required: true

  has n, :spaces, through: Resource


  def self.validate(start,finish)
  	return ['Please put in both the start and end date.'] if (start.empty? or finish.empty?)
  	start_day = DateTime.parse(start)
  	finish_day = DateTime.parse(finish)
  	return ['Start date must be before end date'] if start_day > finish_day
  	return ['That ship has sailed'] if DateTime.now > start_day
  	"pass"
  end

  def self.days_to_array(start,finish)
  	start_day = DateTime.parse(start)
    finish_day = DateTime.parse(finish)
    (start_day..finish_day).group_by(&:day).map{ |_,day| day }
  end
  
end
