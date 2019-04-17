class UsersController < ApplicationController
  before_action :set_user, only: [show, edit, update, destroy]
  def index
    @users = User.all
  end

  def show
  end

  def new
    # モデルオブジェクトの生成
    @user = User.new
  end

  def create
    # formのデータを受け取る
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: 'ユーザーのアップデートが成功しました。'
    else
      render 'edit', notice: 'ユーザーのアップデートが失敗しました。'
    end
  end

  def destroy
    if @user.destroy
      redirect_to users_path notice: 'ユーザーが削除されました。'
    else
      render 'edit', notice: 'ユーザーの削除に失敗しました。'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :sex)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
