feature "available dates" do

  before do
    sign_up_and_in
    create_space
  end

  scenario "can add available dates" do
    add_available_date
    expect(AvailableDate.all.size).to eq(1)
  end

  scenario "owner can view available dates" do
    add_available_date
    click_link("Manage space")
    expect(page).to have_content('01-Jun-2016')
  end

  scenario "owner can view available dates" do
    visit "/spaces"
    click_link("My spaces")
    click_link("Manage space")
    fill_in :available_date, with: '2016-06-01'
    click_button 'Submit'
    click_link("Manage space")
    fill_in :available_date, with: '2016-06-01'
    click_button 'Submit'
    expect(AvailableDateSpace.all.size).to eq(1)
    expect(page).to have_content('That date is already available')
  end


end
