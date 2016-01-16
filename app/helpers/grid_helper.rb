module GridHelper

  # make link_to available from grid classes
  def link_to(name = nil, options = nil, html_options = nil, &block)
    ActionController::Base.helpers.link_to(name, options, html_options, &block)
  end

  # make project_path available from grid classes
  def project_path(project)
    Rails.application.routes.url_helpers.project_path(project)
  end

  # make edit_project_path available from grid classes
  def edit_project_path(project)
    Rails.application.routes.url_helpers.edit_project_path(project)
  end
end
