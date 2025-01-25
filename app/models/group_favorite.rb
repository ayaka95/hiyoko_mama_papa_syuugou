class GroupFavorite < ApplicationRecord
  
  belongs_to :group
  belongs_to :group_user
  belongs_to :group_post

  validates :group_user_id, uniqueness: {scope: :group_post_id}

end
