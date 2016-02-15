module ProjectHelper

  def manipulate_project(action, *fields)
    within('.form-horizontal') do
      fill_in :title, with: fields.shift
      click_button action
    end
  end

  def create_project_with(title)
    manipulate_project('Create', title)
  end

  def update_project_with(title)
    manipulate_project('Update', title)
  end

  # create new valid project
  def create_valid_project
    create_project_with 'Some test project'
  end
end
