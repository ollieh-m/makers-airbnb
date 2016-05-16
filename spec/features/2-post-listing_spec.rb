feature "User posts listing" do

	scenario "User can create a space" do
		visit('/spaces/new')
		fill_in('title', with: 'Example title')
		fill_in('location', with: 'Example location')
		fill_in('description', with: 'Example description')
		fill_in('price', with: '20')
		expect{click_button('Create')}.to change{Space.count}.by 1
	end

	scenario "and then list it" do
		visit('/spaces/new')
		fill_in('title', with: 'Example title')
		fill_in('location', with: 'Example location')
		fill_in('description', with: 'Example description')
		fill_in('price', with: '20')
		click_button('Create')
		visit('/spaces')
		expect(page).to have_content("Example title")
	end

end