class Admin::CrudEnumeratorsController < ApplicationController
  before_action :set_model_class
  before_action :set_grid_model_class, only: :index
  before_action :set_model, only: [:show, :edit, :update, :destroy]

  def index
    @grid_model_object = @grid_model_class.new
  end

  def show
  end

  def new
    @model_object = @model_class.new
  end

  def edit
  end

  def create
    @model_object = @model_class.new(prepared_params)

    if @model_object.save
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def update
    if @model_object.update(prepared_params)
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  def destroy
    @model_object.destroy
    redirect_to action: 'index'
  end

  def order_up
    redirect_to action: 'index'
  end

  def order_down
    redirect_to action: 'index'
  end

  private
    def set_model
      @model_object = @model_class.find(params[:id])
    end

    def prepared_params
      params.require(@model_class.model_name.singular)
          .permit(:title, :priority, :status)
    end

    # do override in children
    def set_model_class
      @model_class = nil
      raise NotImplementedError, 'Subclasses must define `set_grid_model_class`.'
    end

    # do override in children
    def set_grid_model_class
      @grid_model_class = nil
      raise NotImplementedError, 'Subclasses must define `set_grid_model_class`.'
    end
end
