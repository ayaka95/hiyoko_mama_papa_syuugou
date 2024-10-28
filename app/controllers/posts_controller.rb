class PostsController < ApplicationController

  before_action :is_matching_login_user, only: [:edit, :update]

  def new
  end

  def index
    @post = Post.new
    @posts = Post.page(params[:page])
  end

  def create
    @posts = Post.page(params[:page])
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post.id)
    else
      render :index
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    post = Post.find(params[:id])
    post.delete
    redirect_to mypage_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :image, :body)
  end

  def is_matching_login_user
    @post = Post.find(params[:id])
    unless @post.user_id == current_user.id
      redirect_to post_path
    end
  end

end
