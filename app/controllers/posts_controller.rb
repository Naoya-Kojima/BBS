class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    @posts = Post.all.includes([:user])
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
    is_posted_by_user?(@post.user)
  end

  def update
    @post = Post.find(params[:id])
    is_posted_by_user?(@post.user)
    if @post.update(post_params)
      redirect_to post_path, notice: '投稿のアップデートが成功しました。'
    else
      flash.now[:alert] = '投稿のアップデートが失敗しました。'
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    is_posted_by_user?(@post.user)
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

  def is_posted_by_user?(user)
    unless current_user == user
      redirect_to posts_path, alert: '他のユーザーの投稿は編集できません。'
    end
  end
end
