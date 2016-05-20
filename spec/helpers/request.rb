module RequestHelpers
  def make_booking_request(space_id: 1)
    visit "/spaces"
    click_link("1")
    fill_in :date, with: '2016-12-01'
    click_button 'Submit Booking'
  end
end