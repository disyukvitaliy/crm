class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :section
      t.string :action

      t.timestamps null: false
    end

    add_index :permissions, [:section, :action]
  end
end
