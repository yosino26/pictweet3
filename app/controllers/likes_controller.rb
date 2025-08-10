class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet

  def create
    unless @tweet.likes.exists?(user: current_user)
      @tweet.likes.create(user: current_user)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to tweets_path }
    end
  end

  def destroy
    like = @tweet.likes.find_by(user: current_user)
    like&.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to tweets_path }
    end
  end

  private

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
