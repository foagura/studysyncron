class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :user_confirmation, only: [:show]

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order("created_at DESC")
  end

  private

  def user_confirmation
    user = User.find(params[:id])
    unless current_user.id == user.id
      redirect_to root_path
    end
  end
end
