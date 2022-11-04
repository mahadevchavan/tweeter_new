class UserController < ApplicationController
  def new

  end

  def updateprofile
    @user = User.new
end
def createProfile
  current_user.image.attach(params[:image])
  if current_user.save!
      redirect_to tweets_path
  else
      render updateprofile_path
  end

end
end
