feature "Approving bookings" do

	before do
		sign_up
		create_space
		add_available_date
		sign_out
		sign_up(name: 'Fluff', email: 'fluff@test.com')
		create_space(title: 'Example 2')
		add_available_date
		make_booking_request(space_id: 1)
		sign_out
		sign_in
	end

	scenario "A user can see a list of the booking requests on the spaces they own" do
		visit '/requests'
		expect(page).to have_content('Example Title')
		expect(page).to have_content('2016-12-01')
		expect(page).not_to have_content('Example 2')
	end

	scenario "A user can approve a booking request" do
		visit '/requests'
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
		space = Space.get(1)
		visit '/requests'
		expect { click_button "Confirm" }.to change { space.available_dates.count }.by(-1)
	end

	scenario "removes date from available dates" do
		space = Space.get(1)
		available_date = space.available_dates.first
		visit '/requests'
		click_button "Confirm"
		space.reload
		expect(space.available_dates).not_to include available_date
	end

end

