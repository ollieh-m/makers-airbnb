feature "Rejecting bookings" do

	before do
		sign_up
		create_space
		add_available_date
		sign_out

		sign_up(name: 'Fluff', email: 'fluff@test.com')
		create_space(title: 'Example 2')
		add_available_date
		sign_out

		sign_up(name: 'Ollie', email: 'ollie@test.com')
		make_booking_request
		sign_out
		sign_in
	end

	scenario "A user can reject a booking request" do
		visit '/bookings/received'
		within '#1' do
			expect(page).to have_button('Reject')
		end
		click_button 'Reject'
		within '#1' do
			expect(page).to have_content('Rejected')
		end
		expect(BookingRequest.first(status: 'Rejected')).not_to be_nil
		within '#1' do
			expect(page).not_to have_button('Reject')
			expect(page).not_to have_button('Confirm')
		end
	end

end
