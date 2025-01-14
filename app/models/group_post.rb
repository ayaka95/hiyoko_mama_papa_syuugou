class GroupPost < ApplicationRecord

  has_one_attached :image
  belongs_to :group_user
  belongs_to :group

  validates :title, presence: true, length: { maximum: 30 }
  validates :body, presence: true, length: { maximum: 100 }

  def get_group_post_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/frame.png')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
