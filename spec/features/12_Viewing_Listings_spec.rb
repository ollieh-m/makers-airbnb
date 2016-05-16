require "spec_helper"

feature "viewing spaces" do

  scenario "viewing spaces on website without being logged in" do
    Space.create(title: "Amazing spot", location: "Awesome Street 123", description: "Loremp Ipsum, Lorem Ipsum", price_per_night: 20)
    # CHANGE BACK TO "/" after merge
    visit "spaces"
    expect(page).to have_content("Amazing spot")
  end

end
