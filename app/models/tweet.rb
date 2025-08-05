class Tweet < ApplicationRecord
  validates :text, presence: true
  belongs_to :user

  has_one_attached :image
  has_many :comments

  # ファイル形式とサイズのバリデーション
  validates :image,
    content_type:   ['image/png', 'image/jpeg'],
    size: { less_than: 5.megabytes, message: 'は5MB以下にしてください' }

  # 保存後に原本を縮小して置き換える
  after_commit :resize_image, if: -> { image.attached? }

  def self.search(search)
    if search != ""
      Tweet.where('text LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end

  private
  def resize_image
    # 既存画像をMiniMagickで加工
    resized = ImageProcessing::MiniMagick
                .source(image.download)
                .resize_to_limit(1200, 1200) # 最大1200pxに縮小
                .call

    # 画像を差し替え（上書き保存）
    image.attach(
      io: File.open(resized.path),
      filename: image.filename.to_s,
      content_type: image.content_type
    )
  end

end
