class Comment < ApplicationRecord
  belongs_to :tweet  # tweetsテーブルとのアソシエーション→tweetモデルの専属である　
  belongs_to :user
end
