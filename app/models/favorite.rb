class Favorite < ApplicationRecord
  
  belongs_to :user
  belongs_to :post
  
  validates :user_id, unipueness: { scope: :post_id }
  
end
