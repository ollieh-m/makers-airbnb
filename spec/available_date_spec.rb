describe AvailableDate do

	context "#self.validate" do
		it "should return correct error if start or end date is empty" do
			expect(AvailableDate.validate("","")).to eq ['Please put in both the start and end date.']
			expect(AvailableDate.validate("","Not empty")).to eq ['Please put in both the start and end date.']
		end

		it "should return correct error if start day is more recent than finish day" do
			expect(AvailableDate.validate("02-06-2016","01-06-2016")).to eq ['Start date must be before end date']
		end

		it "should return correct error if start day is in the past" do
			expect(AvailableDate.validate("19-05-2016","01-06-2016")).to eq ['That ship has sailed']
		end

		it "should return pass if checks do not fail" do
			expect(AvailableDate.validate("01-05-2099","02-05-2099")).to eq "pass"
		end
	end

	context "#self.days_to_array" do

		it "should return an array of date time objects" do
			array = AvailableDate.days_to_array("01-06-2016","03-06-2016")
			expect(array.size).to eq 3
			expect(array.is_a?(Array)).to eq true
			array.each do |date|
				expect(date.class).to eq DateTime
			end
		end
	
	end

end
