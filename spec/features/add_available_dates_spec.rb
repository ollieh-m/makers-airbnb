feature "available dates" do

  before do
    sign_up_and_in
    create_space
  end

  scenario "can add available dates" do
    add_available_date
    expect(AvailableDate.all.size).to eq(3)
  end

  scenario "owner can view available dates" do
    add_available_date
    expect(page).to have_content('01-Jun-2016')
    expect(page).to have_content('02-Jun-2016')
    expect(page).to have_content('03-Jun-2016')
  end

  scenario "owner can't create duplicates of available dates" do
    visit "/spaces"
    click_link("My spaces")
    click_link("Manage space")
    fill_in :available_date_start, with: '2016-06-01'
    fill_in :available_date_finish, with: '2016-06-03'
    click_button 'Submit'
    fill_in :available_date_start, with: '2016-06-01'
    fill_in :available_date_finish, with: '2016-06-03'
    click_button 'Submit'
    expect(AvailableDateSpace.all.size).to eq(3)
  end


end
