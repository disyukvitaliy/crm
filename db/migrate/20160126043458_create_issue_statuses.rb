class CreateIssueStatuses < ActiveRecord::Migration
  def change
    create_table :issue_statuses do |t|
      t.string :title
      t.integer :priority, limit: 1, default: 0
      t.integer :status, limit: 1, default: 0
      t.integer :issue_status, limit: 1, default: 0
      t.integer :element_order, default: 0, null: false

      t.timestamps null: false
    end
  end
end
