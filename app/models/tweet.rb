class Tweet < ApplicationRecord
  validates :text, presence: true
  belongs_to :user

  has_one_attached :image
  has_many :comments

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  # ファイル形式とサイズのバリデーション（画像があるときだけチェック）
  validates :image,
    content_type: ['image/png', 'image/jpeg'],
    size: { less_than: 5.megabytes, message: 'は5MB以下にしてください' },
    if: -> { image.attached? }

  # 保存後に原本を縮小して置き換える
  after_commit :resize_image, if: -> { image.attached? }

  def self.search(search)
    if search.present?
      Tweet.where('text LIKE ?', "%#{search}%")
    else
      Tweet.all
    end
  end

  private
  def resize_image
    # 元画像をMiniMagickで加工してTempfileを作成
    resized = ImageProcessing::MiniMagick
                .source(image.download)
                .resize_to_limit(1200, 1200)
                .call

    # Tempfileのままattach（File.open不要）
    image.attach(
      io: resized,
      filename: image.filename.to_s,
      content_type: image.content_type
    )

    # 一時ファイルを削除
    resized.close!
    resized.unlink
  rescue => e
    Rails.logger.error "Image resize failed: #{e.message}"
  end
end
