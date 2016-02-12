class Admin::EnumeratorsController < ApplicationController
  def index
    authorize Activity
    authorize IssuePriority
    @activities_grid = ActivitiesGrid.new
    @issue_priorities_grid = IssuePrioritiesGrid.new
  end
end
