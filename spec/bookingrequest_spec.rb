describe BookingRequest do
	
	let(:user){	User.create(name: 'Example',
                					email: 'user@example.com',
                					password: 'secret',
                					password_confirmation: 'secret') }
	let(:space){ Space.create(title: 'Example',
													location: 'Example',
													description: 'Example',
													price: '20',
													user: user) }
	subject(:request){ BookingRequest.create(date: DateTime.new(2001,2,3), user: user, space: space) }

	it "reformats the datetime object" do
		expect(subject.formatted_date).to eq "2001-02-03"
	end

	it "returns true if the booking request is under the same person as the owner of the space" do
		expect(subject.self_booking?).to eq true
	end

end