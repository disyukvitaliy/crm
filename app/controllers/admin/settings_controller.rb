class Admin::SettingsController < ApplicationController
  include CrudConcern

  private

  def set_model_class
    @model_class = Setting
  end

  def prepared_params
    super { [:site_name, :host_name] }
  end
end
