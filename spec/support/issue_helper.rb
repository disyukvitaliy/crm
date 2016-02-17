module IssueHelper

  def manipulate_issue(action, fields)
    within('.form-horizontal') do
      fill_in :issue_subj, with: fields.shift
      fill_in :issue_descr, with: fields.shift
      fill_in :issue_estimated_time, with: fields.shift
      select fields.shift || first('#issue_issue_priority_id option').text, from: :issue_issue_priority_id
      select fields.shift || first('#issue_issue_status_id option').text, from: :issue_issue_status_id
      click_button action
    end
  end

  def create_issue_with(*fields)
    manipulate_issue('Create', fields)
  end

  def update_issue_with(*fields)
    manipulate_issue('Update', fields)
  end
end
