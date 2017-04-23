class UsersController < ApplicationController
  def index
    @user = User.find_by_id(params[:id])
  end

  def friends
    @friends = User.friends(current_user)
  end

  private

  def user_urls
    @user_urls ||= @user.urls.paginate(page: params[:page], per_page: 10)
  end

  helper_method :user_urls
end
