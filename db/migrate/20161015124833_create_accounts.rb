class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string   "username",   null: false
      t.string   "api_key",    null: false
      t.integer  "user_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["user_id"], name: "index_accounts_on_user_id", using: :btree
    end
  end
end
