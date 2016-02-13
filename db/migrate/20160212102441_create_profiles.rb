class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :second_name
      t.date :birthday
      t.attachment :ava
      t.references :user, index: true, foreign_key: {name: :fk_profile_on_user_id, on_delete: :cascade}

      t.timestamps null: false
    end
  end
end
