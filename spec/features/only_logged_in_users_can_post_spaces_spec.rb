require "spec_helper"

feature "only logged in users can post spaces" do

  scenario "creating a space as a logged in user" do
    sign_up_and_in
    click_link('create a new space')
    expect(page).not_to have_content("Please log in first")
    fill_in_create_space_form
    expect{click_button('Create')}.to change{Space.count}.by 1
  end

  scenario "creating a space when your not logged in" do
    visit('/spaces/new')
    expect(page).to have_content("Please log in first")
  end

  scenario "visting space creation page when not logged in does not give users access to the form" do
    visit('/spaces/new')
    expect(page).not_to have_content("Title:")
  end


end
