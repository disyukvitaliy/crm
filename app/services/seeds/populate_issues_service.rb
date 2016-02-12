class Seeds::PopulateIssuesService
  def call
    Project.all.each do |p|
      p.issues.create do |is|
        is.subj = "Issue ##{p.id}"
        is.descr = "Some description for this simple issue ##{p.id}"
        is.start_date = p.id.day.from_now.strftime('%Y-%m-%d')
        is.due_date = p.id.day.from_now.strftime('%Y-%m-%d')
        is.issue_status_id = nil
        is.issue_priority_id = nil
        is.estimated_time = 1.5
        is.user_id = User.first.id
      end
    end
  end
end
