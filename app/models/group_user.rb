class GroupUser < ApplicationRecord

  belongs_to :group
  belongs_to :user
  has_many :group_posts, dependent: :destroy
  has_many :group_comments, dependent: :destroy

  def get_profile_image(width, height)
    unless user.profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      user.profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    user.profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
