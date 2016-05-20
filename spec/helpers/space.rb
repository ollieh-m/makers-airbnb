module SpaceHelpers
  def fill_in_create_space_form
    visit '/spaces'
    click_link 'Create a new space'
    fill_in('title', with: 'Example title')
    fill_in('location', with: 'Example location')
    fill_in('description', with: 'Example description')
    fill_in('price', with: '20')
  end

  def create_space(title: 'Example Title', location: 'Example location', description: 'Example description', price: '20')
    visit '/spaces'
    click_link 'Create a new space'
    fill_in('title', with: title)
    fill_in('location', with: location)
    fill_in('description', with: description)
    fill_in('price', with: price)
    click_button 'Create'
  end

  def create_wrong_space
    visit '/spaces'
    click_link 'Create a new space'
    fill_in('title', with: 'Fail title')
    fill_in('location', with: 'Fail location')
    fill_in('description', with: 'Fail description')
    fill_in('price', with: '20')
    click_button 'Create'
  end

  def add_available_date()
    visit "/spaces"
    click_link("My spaces")
    click_link("1")
    fill_in :available_date_start, with: '2016-12-01'
    fill_in :available_date_finish, with: '2016-12-03'
    click_button 'Submit'
  end
end