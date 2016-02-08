class CreateRolePermissions < ActiveRecord::Migration
  def change
    create_table :role_permissions do |t|
      t.references :role, index: true, foreign_key: {name: :fk_role_permissions_on_role_id, on_delete: :cascade}
      t.references :permission, index: true, foreign_key: {name: :fk_role_permissions_on_permission_id, on_delete: :cascade}

      t.timestamps null: false
    end
  end
end
