module ActivityHelper

  def manipulate_activity(action, *fields)
    within('.form-horizontal') do
      fill_in :title, with: fields.shift
      click_button action
    end
  end

  def create_activity_with(title)
    manipulate_activity('Create', title)
  end

  def update_activity_with(title)
    manipulate_activity('Update', title)
  end

  # create new valid activity
  def create_valid_activity
    create_activity_with 'Some test activity'
  end
end
