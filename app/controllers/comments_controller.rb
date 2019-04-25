class CommentsController < ApplicationController
  before_action :set_post, only: [:show, :new, :create, :edit]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comment = Comment.new
  end

  def show
    @comment = Comment.find_by(post_id: @post.id)
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      redirect_to post_path(@post), notice: 'コメントの投稿に成功しました。'
    else
      render post_path(@post), notice: 'コメントの投稿に失敗しました。'
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to comment_path, notice: 'コメントのアップデートが成功しました。'
    else
      render 'edit', notice: 'コメントのアップデートが失敗しました。'
    end
  end

  def destroy
    if @comment.destroy
      redirect_to post_path(@comment.post_id), notice: 'コメントが削除されました。'
    else
      render 'edit', notice: 'コメントの削除に失敗しました。'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
