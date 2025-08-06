class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def create
    @tweet.likes.create(user: current_user)
    redirect_to tweets_path
  end

  def destroy
    like = @tweet.likes.find_by(user: current_user)
    like.destroy if like
    redirect_to tweets_path
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
