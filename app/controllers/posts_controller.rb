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
      flash[:success] = '投稿に成功しました。'
      redirect_to root_path
    else
      flash[:warning] = '投稿に失敗しました。'
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
    unless @post.is_posted_by_user?(current_user)
      flash[:danger] = '他のユーザーの投稿は編集できません。'
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])

    unless @post.is_posted_by_user?(current_user)
      flash[:danger] = '他のユーザーの投稿は編集できません。'
      redirect_to posts_path
    end

    if @post.update(post_params)
      flash[:success] = '投稿のアップデートが成功しました。'
      redirect_to post_path
    else
      flash[:warning] = '投稿のアップデートが失敗しました。'
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])

    unless @post.is_posted_by_user?(current_user)
      flash[:danger] = '他のユーザーの投稿は編集できません。'
      redirect_to posts_path
    end

    if @post.destroy
      flash[:success] = '投稿が削除されました。'
      redirect_to posts_path
    else
      flash[:warning] = '投稿の削除に失敗しました。'
      render 'edit'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
