class ProfilesController < ApplicationController
  include CrudConcern

  private

  def set_model_classes
    {model_class: Profile}
  end

  def set_model_object
    super { current_user.profile }
  end

  def prepared_params
    super { [:first_name, :second_name, :birthday, :ava] }
  end

  def redirect_after_successful_update
    super { edit_profile_path }
  end
end
