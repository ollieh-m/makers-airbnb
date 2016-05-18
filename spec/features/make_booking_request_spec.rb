feature "a user can make a booking request" do

  before do
    sign_up_and_in
    create_space
    add_available_date
  end

  scenario "user can make a booking request on the detail page of a space" do
    sign_out
    sign_up(name:'Letian', email:'letian@yahoo.com')
    make_booking_request
    expect(BookingRequest.all.length).to eq(1)
    expect(BookingRequest.all.first.user.name).to eq('Letian')
    expect(BookingRequest.all.first.space.title).to eq('Example Title')
  end

  scenario "user cannot make a booking request on his own spaces" do
    make_booking_request
    expect(BookingRequest.all.length).to eq(0)
    expect(page).to have_content('You cannot book your own space')
  end

end
