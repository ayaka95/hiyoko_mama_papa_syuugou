class Group < ApplicationRecord
  
  has_one_attached :image
  belongs_to :owner, class_name: 'User'
  
  validates :name, presence: true, uniqueness: true, length: { maximum: 30 }
  validates :introduction, presence: true, length: { maximum: 100 }
  
end
