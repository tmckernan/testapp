class Recipient < ActiveRecord::Base
  validates :name, :recipient_id, :user_id, presence: true
  belongs_to :user
  has_many :payments
end
