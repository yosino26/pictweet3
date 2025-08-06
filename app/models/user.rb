class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :tweets
         has_many :comments  # commentsテーブルとのアソシエーション　　　追記

         has_many :likes, dependent: :destroy
         has_many :liked_tweets, through: :likes, source: :tweet
end
