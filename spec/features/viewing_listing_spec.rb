feature "viewing spaces" do

  before do
    current_user = User.create( name: 'Lexi',
                                email: 'hello@example.com',
                                password: 'hello',
                                password_confirmation: 'hello')
    current_user.spaces.create( title: "Amazing spot",
                                location: "Awesome Street 123",
                                description: "Loremp Ipsum, Lorem Ipsum",
                                price: 20)

  end

  scenario "viewing spaces on website without being logged in" do
    visit "/spaces"
    expect(page).to have_content("Amazing spot")
  end

end
