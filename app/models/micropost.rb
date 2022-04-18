class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :content, presence: true, length: {maximum: Settings.max_length_140}
  validates :image, content_type: {in: Settings.image_type},
  size: {less_than: Settings.image_megabytes_5.megabytes}

  scope :recent_posts, ->{order created_at: :desc}

  def display_image
    image.variant resize_to_limit: [
      Settings.image_max_width_500,
      Settings.image_max_height_500
    ]
  end
end
