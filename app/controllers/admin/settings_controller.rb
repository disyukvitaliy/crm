class Admin::SettingsController < ApplicationController

  def edit
  end

  def update
    if @settings.update(setting_params)
      redirect_to action: :edit
    else
      render 'edit'
    end
  end

  private

  def setting_params
    params.require(:setting).permit(:site_name, :host_name)
  end

end
