feature 'Viewing individual spaces' do

  scenario "Can click on one space and get details of only this space" do
    sign_up_and_in
    create_space
    create_wrong_space
    expect(Space.all.count).to eq 2
    click_link("Book", :href => '/spaces/1')
    expect(page).to have_content ("Example Title")
    expect(page).not_to have_content ("Fail")
  end

end
