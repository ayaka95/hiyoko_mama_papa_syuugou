class GroupComment < ApplicationRecord

  belongs_to :group_user
  belongs_to :group_post
  belongs_to :group

  validates :group_comment, presence: true, length: { maximum: 50 }

  
end
