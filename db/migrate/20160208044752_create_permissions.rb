class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :model
      t.string :action

      t.timestamps null: false
    end

    add_index :permissions, [:model, :action]
  end
end
