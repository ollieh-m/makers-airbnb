feature 'Sign in' do
  let(:user) do
    User.create(name: 'Example',
                email: 'user@example.com',
                password: 'secret',
                password_confirmation: 'secret')
  end

  scenario 'correctly sign in' do
    sign_in(email: user.email, password: user.password)
    expect(page).to have_content "Example"
  end
end