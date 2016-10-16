class CreateRecipients < ActiveRecord::Migration
  def change
    create_table :recipients do |t|
      t.string   "name", null: false
      t.string   "recipient_id", null: false
      t.integer  "user_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["user_id"], name: "index_recipients_on_user_id", using: :btree
    end
  end
end
