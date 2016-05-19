feature 'user cannot book a date that is not available' do

  before do
    sign_up_and_in
    create_space
    sign_out
    sign_up(name: 'Letian', email: 'Hulk@avengers.com')
    click_link("1")
  end

  scenario 'renter should be able to see available dates in space detail page' do
    make_booking_request
    expect(page).to have_content('The space is not available on that date')
    expect(Space.get(1).booking_requests).to be_empty
  end


end
