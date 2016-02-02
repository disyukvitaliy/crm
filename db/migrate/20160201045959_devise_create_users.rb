class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|

      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Rememberable
      t.datetime :remember_created_at

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.boolean :status, default: false, null: false

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :status
  end
end
