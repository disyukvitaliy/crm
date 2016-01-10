class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.belongs_to :project, index: true
      t.text :subj
      t.text :descr
      t.date :start_date
      t.date :due_date

      t.timestamps null: false
    end
  end
end
