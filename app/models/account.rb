class Account < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :api_key, :username, presence: true
end
