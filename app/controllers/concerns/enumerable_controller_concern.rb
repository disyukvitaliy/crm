module EnumerableControllerConcern
  extend ActiveSupport::Concern

  def set_default
    @model_object.as_default!
    redirect_to request.referer
  end

  def move_up
    @model_object.move_up
    redirect_to request.referer
  end

  def move_down
    @model_object.move_down
    redirect_to request.referer
  end
end