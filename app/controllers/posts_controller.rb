class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :user_confirmation, only: [:edit]

  def index
    @posts = Post.all.order("created_at DESC")
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:study_hours, :study_minutes, 
                                 :title, :content, :start_time).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def user_confirmation
    post = Post.find(params[:id])
    unless current_user.id == post.user_id
      redirect_to root_path
    end
  end
end
