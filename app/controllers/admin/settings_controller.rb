class Admin::SettingsController < ApplicationController
  include AdminControllerConcern
  include CrudConcern

  private

  def set_model_classes
    {model_class: Setting}
  end

  def prepared_params
    super { [:site_name, :host_name] }
  end
end
