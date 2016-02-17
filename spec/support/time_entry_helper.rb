module TimeEntryHelper

  def manipulate_time_entry(action, fields)
    within('.form-horizontal') do
      fill_in :time_entry_date, with: fields.shift
      fill_in :time_entry_amount, with: fields.shift
      select fields.shift || first('#time_entry_activity_id option').text, from: :time_entry_activity_id
      click_button action
    end
  end

  def create_time_entry_with(*fields)
    manipulate_time_entry('Create', fields)
  end

  def update_time_entry_with(*fields)
    manipulate_time_entry('Update', fields)
  end
end
