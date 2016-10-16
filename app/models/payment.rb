class Payment < ActiveRecord::Base
  validates :currency, :payment_id, :amount, :recipient_id, presence: true
  belongs_to :recipient
end
