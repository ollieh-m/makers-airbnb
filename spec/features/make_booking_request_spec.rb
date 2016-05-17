feature "a user can make a booking request" do

  before do
    sign_up_and_in
    create_space
  end

  scenario "user can make a booking request on the detail page of a space" do
    make_booking_request
    expect(BookingRequest.all.length).to eq(1)
    expect(BookingRequest.all.first.user.name).to eq('Lexi')
    expect(BookingRequest.all.first.space.title).to eq('Example Title')
  end

end