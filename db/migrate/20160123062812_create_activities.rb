class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :title
      t.integer :priority, limit: 1, default: 0
      t.integer :status, limit: 1, default: 0
      t.integer :order, limit: 2

      t.timestamps null: false
    end
    add_index :activities, :order, unique: true
  end
end
