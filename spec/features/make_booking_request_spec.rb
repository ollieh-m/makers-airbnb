feature "a user can make a booking request" do

  before do
    sign_up_and_in
    create_space
  end

  scenario "user can make a booking request on the detail page of a space" do
    visit "/spaces"
    click_link "Details"
    expect(page).to have_button("Book")
    fill_in :date, with: '2016-06-01'
    click_button 'Submit Booking'
    expect(BookingRequest.all.length).to eq(1)
    expect(BookingRequest.all.first.user.name).to eq('Lexi')
    expect(BookingRequest.all.first.space.title).to eq('Example Title')
    #change(@space.booking_requests.length).by(1)
  end

end