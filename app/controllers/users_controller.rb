class UsersController < ApplicationController
  before_action :require_login, only: [:index, :show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: 'ユーザーの作成に成功しました。'
    else
      flash.now[:alert] = 'ユーザーの作成に失敗しました。'
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    unless @user.is_created_by_user?(current_user)
      redirect_to users_path, alert: '他のユーザーの情報は編集できません。'
    end
  end

  def update
    @user = User.find(params[:id])
    unless @user.is_created_by_user?(current_user)
      redirect_to users_path, alert: '他のユーザーの情報は編集できません。'
    end
    if @user.update(user_params)
      redirect_to user_path, notice: 'ユーザーのアップデートが成功しました。'
    else
      flash.now[:alert] = 'ユーザーのアップデートが失敗しました。'
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    unless @user.is_created_by_user?(current_user)
      redirect_to users_path, alert: '他のユーザーの情報は編集できません。'
    end
    if @user.destroy
      redirect_to users_path notice: 'ユーザーが削除されました。'
    else
      flash.now[:alert] = 'ユーザーの削除に失敗しました。'
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :sex)
  end
end
