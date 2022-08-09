class Micropost < ApplicationRecord
  belongs_to :user

  has_one_attached :image

  validates :content, presence: true, length: {maximum: Settings.digit_140}
  validates :image, content_type: {in: Settings.micropost.image_path,
                                   message: :wrong_format},
                    size: {less_than: Settings.micropost.image_size.megabytes,
                           message: :too_big}

  scope :newest, ->{order created_at: :desc}
  scope :relate_post, ->(user_ids){where user_id: user_ids}

  delegate :name, to: :user, prefix: true

  def display_image
    image.variant resize_to_limit: Settings.micropost.resize_to_limit
  end
end
