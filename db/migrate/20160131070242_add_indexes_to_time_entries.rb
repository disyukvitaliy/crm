class AddIndexesToTimeEntries < ActiveRecord::Migration
  def change
    add_index :time_entries, :amount
    add_index :time_entries, :date
  end
end
