def sign_up(name: 'Lexi', email: 'hazukitran@gmail.com', password: 'hello', password_confirmation: 'hello')
  visit '/users/new'
  fill_in :name, with: name
  fill_in :email, with: email
  fill_in :password, with: password
  fill_in :password_confirmation, with: password_confirmation
  click_button 'Sign up'
end

def sign_out
  click_button('Sign out')
end

def make_booking_request(space_id: 1)
  visit "/spaces"
  click_link("1")
  fill_in :date, with: '2016-12-01'
  click_button 'Submit Booking'
end

def sign_up_correctly
  visit '/users/new'
  fill_in :name, with: 'Lexi'
  fill_in :email, with: 'hazukitran@gmail.com'
  fill_in :password, with: 'hello'
  fill_in :password_confirmation, with: 'hello'
  click_button 'Sign up'
end

def sign_up_incorrectly
  visit '/users/new'
  fill_in :name, with: 'Lexi'
  fill_in :email, with: 'hazukitran@gmail.com'
  fill_in :password, with: 'hello'
  fill_in :password_confirmation, with: 'helloworld'
  click_button 'Sign up'
end

def sign_up_without_email
  visit '/users/new'
  fill_in :email, with: ""
  click_button 'Sign up'
end

def sign_up_invalid_email
  visit '/users/new'
  fill_in :email, with: "dhfgo.@com"
  click_button 'Sign up'
end

def sign_in(email: 'hazukitran@gmail.com', password: 'hello')
  visit '/sessions/new'
  fill_in :email, with: email
  fill_in :password, with: password
  click_button 'Sign in'
end

def sign_up_and_in
  visit '/users/new'
  fill_in :name, with: 'Lexi'
  fill_in :email, with: 'hazukitran@gmail.com'
  fill_in :password, with: 'hello'
  fill_in :password_confirmation, with: 'hello'
  click_button 'Sign up'
  visit '/sessions/new'
  fill_in :email, with: 'hazukitran@gmail.com'
  fill_in :password, with: 'hello'
  click_button 'Sign in'
end

def fill_in_create_space_form
  visit '/spaces'
  click_link 'create a new space'
  fill_in('title', with: 'Example title')
  fill_in('location', with: 'Example location')
  fill_in('description', with: 'Example description')
  fill_in('price', with: '20')
end

def create_space(title: 'Example Title', location: 'Example location', description: 'Example description', price: '20')
  visit '/spaces'
  click_link 'create a new space'
  fill_in('title', with: title)
  fill_in('location', with: location)
  fill_in('description', with: description)
  fill_in('price', with: price)
  click_button 'Create'
end

def create_wrong_space
  visit '/spaces'
  click_link 'create a new space'
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
