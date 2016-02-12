class Seeds::PopulateProjectsService
  def call
    11.times do |i|
      Project.find_or_create_by!(id: i+1) do |p|
        p.title = "Project ##{i+1}"
        p.descr = "Some description for this simple project ##{i+1}"
        p.user_id = User.first.id
      end
    end

    Project.find(2).update_attribute(:parent_id, 1)
    Project.find(5).update_attribute(:parent_id, 3)
  end
end
