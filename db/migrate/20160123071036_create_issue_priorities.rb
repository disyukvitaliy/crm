class CreateIssuePriorities < ActiveRecord::Migration
  def change
    create_table :issue_priorities do |t|
      t.string :title
      t.integer :priority, limit: 1, default: 0
      t.integer :status, limit: 1, default: 0
      t.integer :order, limit: 2

      t.timestamps null: false
    end
    add_index :issue_priorities, :order, unique: true
  end
end
