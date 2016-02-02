class Auth::RegistrationsController < Devise::RegistrationsController
  layout 'authentication', only: [:new, :create]

  # user can not edit User model
  before_action 'raise ActionController::RoutingError.new("Not Found")', only: [:edit, :update]

  protected

  def after_inactive_sign_up_path_for(resource)
    :new_user_session # Or :prefix_to_your_route
  end
end
