class Seeds::PopulateActivitiesService
  def call
    5.times do |i|
      Activity.find_or_create_by!(id: i+1) do |is|
        is.title = "Activity ##{i+1}"
        is.status = Activity.statuses[:active]
      end
    end
    Activity.find(2).update_attribute(:priority, Activity.priorities[:default])
  end
end
