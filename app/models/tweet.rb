class Tweet < ApplicationRecord
  validates :text, presence: true
  belongs_to :user

  has_one_attached :image
  # ファイル形式とサイズのバリデーション
    validates :image,
    content_type: ['image/png', 'image/jpg', 'image/jpeg'],
    size: { less_than: 5.megabytes, message: 'は5MB以下にしてください' }

  has_many :comments  # commentsテーブルとのアソシエーション　追記

  def self.search(search)
    if search != ""
      Tweet.where('text LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end
end
