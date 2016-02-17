module AuthorizationHelper

  # sign in as valid user
  # @return User - signed in user model
  def sign_in
    user = User.find_by_email('admin@example.com')
    visit new_user_session_path
    sign_in_with user.email, 'adminexample'
    user
  end

  def sign_in_with(*fields)
    within '#new_user' do
      fill_in :user_email, with: fields.shift
      fill_in :user_password, with: fields.shift
      click_button 'Log in'
    end
  end

  def sign_up_with(*fields)
    within '#new_user' do
      fill_in :user_email, with: fields.shift
      fill_in :user_password, with: fields.shift
      fill_in :user_password_confirmation, with: fields.shift
      click_button 'Sign up'
    end
  end

  def restore_password_for(email)
    within '#new_user' do
      fill_in :user_email, with: email
      click_button 'Send me reset password instructions'
    end
  end
end
