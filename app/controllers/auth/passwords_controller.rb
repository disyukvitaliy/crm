class Auth::PasswordsController < Devise::PasswordsController
  layout 'authentication', only: [:new, :create, :edit, :update]
end
