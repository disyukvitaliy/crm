class AddSlugToProject < ActiveRecord::Migration
  def change
    remove_column :projects, :alias
    add_column :projects, :slug, :string, null: false
    add_index :projects, :slug, unique: true
  end
end
