class CommentsController < ApplicationController
  def show
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id if current_user

    if @comment.save
      flash[:success] = 'コメントの投稿に成功しました。'
      redirect_to post_path(@post)
    else
      flash[:warning] = 'コメントの投稿に失敗しました。'
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    unless @comment.can_be_edited_by_user?(current_user)
      flash[:danger] = '他のユーザーのコメントは編集できません。'
      redirect_to @post
    end
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    unless @comment.can_be_edited_by_user?(current_user)
      flash[:danger] = '他のユーザーのコメントは編集できません。'
      redirect_to @post
    end

    if @comment.update(comment_params)
      flash[:success] = 'コメントのアップデートが成功しました。'
      redirect_to post_path(@post)
    else
      flash[:warning] = 'コメントのアップデートが失敗しました。'
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])

    unless @comment.can_be_edited_by_user?(current_user)
      flash[:danger] = '他のユーザーのコメントは編集できません。'
      redirect_to @post
    end

    if @comment.destroy
      redirect_to @post, notice: 'コメントが削除されました。'
    else
      flash[:warning] = 'コメントの削除に失敗しました。'
      render 'edit'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
