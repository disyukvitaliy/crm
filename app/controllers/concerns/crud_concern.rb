module CrudConcern
  extend ActiveSupport::Concern

  included do
    before_action :init_model_classes
    before_action :set_model_object, only: [:show, :edit, :update, :destroy]
  end

  def index
    param_name = @grid_model_class.model_name.singular
    @grid_model_object = @grid_model_class.new(params[param_name]) do |scope|
      (block_given? ? yield(scope) : scope).page(params[:page]).per(5)
    end
  end

  def new
    @model_object = block_given? ? yield : @model_class.new
  end

  def edit
    # authorize @model_object
  end

  def create
    @model_object = build_model_object(prepared_params)
    @model_object.save

    yield @model_object if block_given?

    if @model_object.persisted?
      redirect_after_successful_create
    else
      render :new
    end
  end

  def update
    @model_object.update(prepared_params)

    yield @model_object if block_given?

    if @model_object.errors.empty?
      redirect_after_successful_update
    else
      render :edit
    end
  end

  def destroy
    respond_to do |format|
      format.js do
        if @model_object.destroy
          after_successful_js_destroy
        else
          render js: "alert('#{@model_object.errors.full_messages.join('\n')}')"
        end
      end
      format.html do
        if @model_object.destroy
          redirect_after_successful_html_destroy @model_object
        else
          render :edit
        end
      end
    end
  end

  private

  def init_model_classes
    @model_class = set_model_class
    @grid_model_class = set_grid_model_class
  end

  # do override in children
  # == Example
  #   {model_class: Project, grid_model_class: ProjectsGrid}
  def set_model_classes
    raise NotImplementedError, 'Subclasses must define `set_model_classes`.'
  end

  # @return [ActiveRecord::Base]
  def set_model_class
    set_model_classes[:model_class]
  end

  # @return [Datagrid]
  def set_grid_model_class
    set_model_classes[:grid_model_class]
  end

  def set_model_object
    @model_object = @model_class.find(params[:id])
  end

  # build new model object from params
  # @param model_params [Hash]
  # @return [ActiveRecord::Base]
  def build_model_object(model_params)
    @model_class.new(model_params)
  end

  # @return [Hash]
  def prepared_params
    params.require(@model_class.model_name.singular).permit(yield)
  end

  def redirect_after_successful_update
    redirect_to({action: :edit, id: @model_object.to_param}, notice: 'Has successfully updated')
  end

  def redirect_after_successful_create
    redirect_to({action: :edit, id: @model_object.to_param}, notice: 'Has successfully created')
  end

  # @param model_object [ActiveRecord::Base]
  def redirect_after_successful_html_destroy(model_object = nil)
    redirect_to action: :index
  end

  def after_successful_js_destroy
    render js: "window.location = '#{request.referer}'"
  end
end