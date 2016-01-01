class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.text :title, null: false
      t.text :body, null: false
      t.text :alias, null: false

      t.timestamps null: false
    end
  end
end
