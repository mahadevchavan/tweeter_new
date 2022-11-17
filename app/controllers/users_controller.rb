class UsersController < ApplicationController
  def new
  end

  def follow
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @tweets =
      begin
        @user.tweets
      rescue StandardError
        nil
      end
  end

  def unfollow
    @user = current_user
  end
  def set_user
    @user = User.find(params[:id])
  end

  def updateprofile
    @user = User.new
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    @following = current_user.followings.all
    render "following"
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    @follower = current_user.followers.all

    render "followers"
  end

  # def destroy
  # end

  def createProfile
    current_user.image.attach(params[:image])
    if current_user.save!
      redirect_to tweets_path
    else
      render updateprofile_path
    end
  end
end
