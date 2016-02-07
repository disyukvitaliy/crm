class AddUserIdToModels < ActiveRecord::Migration
  def change
    add_reference :projects, :user, index: true, foreign_key: {name: :fk_projects_on_user_id, on_delete: :nullify}
    add_reference :issues, :user, index: true, foreign_key: {name: :fk_issues_on_user_id, on_delete: :nullify}
    add_reference :time_entries, :user, index: true, foreign_key: {name: :fk_time_entries_on_user_id, on_delete: :nullify}
  end
end
