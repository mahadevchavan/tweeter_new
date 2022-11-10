class CommentsController < ApplicationController
  before_action :set_tweet
  before_action :authenticate_user!
  def new
  end

  def create
    @tweet = Tweet.find(params[:tweet_id])
    @comment =
      @tweet.comments.create(
        params[:comment].permit(:body).merge(user_id: current_user.id)
      )
    redirect_to tweet_path(@tweet)
    @comment.save
  end

  private

  def comments_params
    params.require(:comment).permit(:body, :comment_id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end
end
