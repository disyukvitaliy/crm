class UserProject < ActiveRecord::Migration
  def change
    create_table :user_projects, id: false do |t|
      t.references :user, index: true, foreign_key: {name: :fk_user_projects_on_user_id, on_delete: :cascade}
      t.references :project, index: true, foreign_key: {name: :fk_user_projects_on_project_id, on_delete: :cascade}
    end
  end
end
