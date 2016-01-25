class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :site_name
      t.string :host_name

      t.timestamps null: false
    end
  end
end
