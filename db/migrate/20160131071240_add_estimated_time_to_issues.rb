class AddEstimatedTimeToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :estimated_time, :integer
    add_index :issues, :estimated_time
  end
end
