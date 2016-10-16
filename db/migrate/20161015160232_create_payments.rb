class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string   "payment_id", null: false
      t.string   "currency", null: false
      t.decimal  "amount", null: false
      t.integer  "recipient_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["recipient_id"], name: "index_payments_on_recipient_id", using: :btree
    end
  end
end
