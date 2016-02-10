# TODO make it independent from CrudConcern
module EnumerableControllerConcern
  extend ActiveSupport::Concern

  def set_default
    get_model_object.as_default!
    redirect_to request.referer
  end

  def move_up
    get_model_object.move_up
    redirect_to request.referer
  end

  def move_down
    get_model_object.move_down
    redirect_to request.referer
  end
end