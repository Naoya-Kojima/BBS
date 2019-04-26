class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :edit, :create, :update, :destroy]

  def index
    @posts = Post.all.includes([:user])
  end

  def new
    @post = Post.new
  end

  def show
    @comments = @post.comments.all.order(id: "DESC").includes([:user])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to root_path, notice: '投稿に成功しました。'
    else
      flash.now[:alert] = '投稿に失敗しました。'
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path, notice: '投稿のアップデートが成功しました。'
    else
      flash.now[:alert] = '投稿のアップデートが失敗しました。'
      render 'edit'
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path notice: '投稿が削除されました。'
    else
      flash.now[:alert] = '投稿の削除に失敗しました。'
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
