feature "Approving bookings" do

	before do
		sign_up
		create_space
		create_space(title: 'Example 2')
		click_link "My spaces"
		click_link("Manage space", :href => '/users/spaces/2')
		fill_in :available_date, with: '2016-06-01'
		click_button "Submit"
		sign_out
		sign_up(name: 'Ollie', email: 'ollie@test.com')
		make_booking_request(space_id: 2)
		sign_out
		sign_in
	end

	scenario "A user can see a list of the booking requests on the spaces they own" do
		visit '/bookings/received'
		expect(page).to have_content('Example 2')
		expect(page).to have_content('2016-06-01')
		expect(page).not_to have_content('Example Title')
	end

	scenario "A user can approve a booking request" do
		visit '/bookings/received'
		within '#1' do
			expect(page).to have_button('Confirm')
		end
		click_button 'Confirm'
		within '#1' do
			expect(page).to have_content('Confirmed')
		end
		expect(BookingRequest.first(status: 'Confirmed')).not_to be_nil
		within '#1' do
			expect(page).not_to have_button('Confirm')
		end
	end

	scenario "after booking confirmed, date is not available" do
		space = Space.get(2)
		visit 'bookings/received'
		expect { click_button "Confirm" }.to change { space.available_dates.count }.by(-1)
	end

	scenario "removes date from available dates" do
		space = Space.get(2)
		available_date = space.available_dates.first
		visit 'bookings/received'
		click_button "Confirm"
		space.reload
		expect(space.available_dates).not_to include available_date
	end

end