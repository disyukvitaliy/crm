class Seeds::PopulateIssuePrioritiesService
  def call
    5.times do |i|
      IssuePriority.find_or_create_by!(id: i+1) do |is|
        is.title = "IssuePriority ##{i+1}"
        is.status = IssuePriority.statuses[:active]
      end
    end
    IssuePriority.find(2).as_default!
  end
end
