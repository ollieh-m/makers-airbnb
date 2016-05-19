feature 'renter can see available dates' do

  before do
    sign_up_and_in
    create_space
    add_available_date
    sign_out
    sign_up(name: 'Letian', email: 'Hulk@avengers.com')
    click_link '1'
  end

  scenario 'renter should be able to see available dates in space detail page' do
    expect(page).to have_content('01-Dec-2016')
  end

end
