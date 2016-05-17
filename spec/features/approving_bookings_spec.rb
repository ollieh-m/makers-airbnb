feature "Approving bookings" do

	before do
		sign_up
		create_space
		create_space(title: 'Example 2')
		sign_out
		sign_up(name: 'Ollie', email: 'ollie@test.com')
		make_booking_request
		sign_out
		sign_in
	end

	scenario "A user can see a list of the booking requests on the spaces they own" do
		visit '/bookings/received'
		expect(page).to have_content('Example Title')
		expect(page).to have_content('2016-06-01')
		expect(page).not_to have_content('Example 2')
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

end