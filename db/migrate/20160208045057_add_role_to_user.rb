class AddRoleToUser < ActiveRecord::Migration
  def change
    add_reference :users, :role, index: true, foreign_key: {name: :fk_users_on_role_id, on_delete: :nullify}
  end
end
