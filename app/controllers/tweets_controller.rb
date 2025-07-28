class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :show]

  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to root_path
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    tweet = Tweet.find(params[:id]) 
    if tweet.destroy
      redirect_to root_path
    else 
      render :show, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.destroy
      redirect_to root_path
    else 
      render :edit, status: :unprocessable_entity
    end
  end
  
  def show
  end

  private
  def tweet_params
    params.require(:tweet).permit(:name, :image, :text)
  end
  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
