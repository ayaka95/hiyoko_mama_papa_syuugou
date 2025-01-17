class GroupComment < ApplicationRecord

  belongs_to :group_user
  belongs_to :group_post

  validates :group_comment, presence: true, length: { maximum: 50 }

  
end
