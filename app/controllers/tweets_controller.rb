class TweetsController < ApplicationController
  @tweets = Tweet.all
end
