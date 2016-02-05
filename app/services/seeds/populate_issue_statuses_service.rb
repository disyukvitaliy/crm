class Seeds::PopulateIssueStatusesService
  def call
    5.times do |i|
      IssueStatus.find_or_create_by!(id: i+1) do |is|
        is.title = "IssueStatus ##{i+1}"
        is.status = IssueStatus.statuses[:active]
      end
    end
    IssueStatus.find(2).as_closing!.as_default!
  end
end
