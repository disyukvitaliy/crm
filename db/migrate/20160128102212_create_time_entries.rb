class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.date :date
      t.integer :amount
      t.text :comment
      t.references :activity, index: true, foreign_key: {name: :fk_time_entries_on_activity_id, on_delete: :nullify}
      t.references :issue, index: true, foreign_key: {name: :fk_time_entries_on_issue_id, on_delete: :cascade}

      t.timestamps null: false
    end
  end
end
