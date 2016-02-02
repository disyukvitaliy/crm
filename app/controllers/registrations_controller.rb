class RegistrationsController < Devise::RegistrationsController
  layout 'authentication', only: [:new, :create]

  def after_inactive_sign_up_path_for(resource)
    :new_user_session # Or :prefix_to_your_route
  end
end
