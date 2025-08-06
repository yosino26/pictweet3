class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  # 同じユーザーが同じツイートに2回以上いいねできないようにする
  validates :user_id, uniqueness: { scope: :tweet_id }
end
