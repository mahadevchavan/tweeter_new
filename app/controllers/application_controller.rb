class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def all_users
    User.where.not id: current_user.id
end
end
