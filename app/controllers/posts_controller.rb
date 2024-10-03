class PostsController < ApplicationController
  def new
  end

  def index
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    #投稿後は投稿詳細へリダイレクトさせたい post_path
    redirect_to posts_path
  end

  def show
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :body)
  end
end
