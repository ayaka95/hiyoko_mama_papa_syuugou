class PostComment < ApplicationRecord
  
  belongs_to :user
  belongs_to :post

  validates :comment, presence: true, length: { maximum: 50 }
end
