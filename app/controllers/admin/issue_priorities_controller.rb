class Admin::IssuePrioritiesController < Admin::CrudEnumeratorsController

  private

    def set_model_class
      @model_class = Admin::IssuePriority
    end

    def set_grid_model_class
      @grid_model_class = IssuePrioritiesGrid
    end
end
