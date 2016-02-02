class Auth::PasswordsController < Devise::PasswordsController
  layout 'authentication', only: [:new, :create]
end
