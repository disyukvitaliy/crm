class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.text :title, null: false
      t.text :descr, null: false
      t.text :alias, null: false
      t.integer :parent_id, index: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true
      t.integer :depth, null: false, default: 0

      t.timestamps null: false
    end
  end
end
