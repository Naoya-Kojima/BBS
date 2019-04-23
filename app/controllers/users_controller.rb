class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'ユーザーの作成に成功しました。'
    else
      render 'new', notice: 'ユーザーの作成に失敗しました。'
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
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :sex)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
