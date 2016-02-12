class IssuesController < ApplicationController
  include CrudConcern

  def index
    super { Project.find(params[:project_id]).issues }
  end

  def create
    super { |issue| issue.update_attributes({user_id: current_user.id}) }
  end

  private

  def set_model_classes
    {model_class: Issue, grid_model_class: IssuesGrid}
  end

  def build_model_object(model_params)
    Project.find(params[:project_id]).issues.new(model_params)
  end

  def prepared_params
    permitted_attributes(get_model_object || Issue)
  end

  def redirect_after_successful_html_destroy(issue)
    redirect_to project_issues_path issue.project
  end
end
