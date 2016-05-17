feature "available dates" do

  before do
    sign_up_and_in
    create_space
  end

  scenario "shows available dates" do
    visit "/spaces"
    click_link("My spaces")
    click_link("Manage space")

    fill_in :available_date, with: '2016-06-01'
    click_button 'Submit'
    expect(AvailableDate.all.size).to eq(1)
  end

end