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

def sign_in(email:, password:)
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

def create_space
  visit '/spaces'
  click_link 'create a new space'
  fill_in('title', with: 'Example Title')
  fill_in('location', with: 'Example location')
  fill_in('description', with: 'Example description')
  fill_in('price', with: '20')
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
