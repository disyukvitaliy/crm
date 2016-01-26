class Admin::ActivitiesController < Admin::CrudEnumeratorsController

  private

    def set_model_class
      @model_class = Activity
    end

    def set_grid_model_class
      @grid_model_class = ActivitiesGrid
    end
end
