class ChangeTimeFormat < ActiveRecord::Migration
  def change
    change_column :issues, :estimated_time, :float
    change_column :time_entries, :amount, :float
  end
end
