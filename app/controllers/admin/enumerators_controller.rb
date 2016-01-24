class Admin::EnumeratorsController < ApplicationController
  def index
    @activities_grid = ActivitiesGrid.new
    @issue_priorities_grid = IssuePrioritiesGrid.new
  end
end
