require "spec_helper"

feature "only logged in users can post spaces" do

  scenario "creating a space as a logged in user" do
    sign_up_and_in
    visit('/spaces/new')
    fill_in('title', with: 'Example title')
    fill_in('location', with: 'Example location')
    fill_in('description', with: 'Example description')
    fill_in('price', with: '20')
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
