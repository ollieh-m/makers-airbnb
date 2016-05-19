feature "User requests" do

  before do
    sign_up
    create_space
    add_available_date
    sign_out
    sign_up(name: 'Fluff', email: 'fluff@test.com')
    make_booking_request(space_id: 1)
  end

  scenario "see their own requests" do
    visit '/requests'
    expect(page).to have_content('Example Title')
    expect(page).not_to have_content("Example 2")
  end

end