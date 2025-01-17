class GroupFavorite < ApplicationRecord
  
  belongs_to :group_user
  belongs_to :group_post

end
