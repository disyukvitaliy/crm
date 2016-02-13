class Admin::SettingsController < ApplicationController
  include AdminControllerConcern
  include CrudConcern

  private

  def set_model_classes
    {model_class: Setting}
  end

  def set_model_object
    super { Setting.first }
  end

  def prepared_params
    super { [:site_name, :host_name] }
  end

  def redirect_after_successful_update
    super { edit_settings_path }
  end
end
