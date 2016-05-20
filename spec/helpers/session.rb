module SessionHelpers

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


end
