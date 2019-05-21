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
      flash[:success] = 'ユーザーの作成に成功しました。'
      redirect_to login_path
    else
      flash[:warning] = 'ユーザーの作成に失敗しました。'
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    unless @user.is_created_by_user?(current_user)
      flash[:danger] = '他のユーザーの情報は編集できません。'
      redirect_to users_path
    end
  end

  def update
    @user = User.find(params[:id])
    unless @user.is_created_by_user?(current_user)
      flash[:danger] = '他のユーザーの情報は編集できません。'
      redirect_to users_path
    end
    if @user.update(user_params)
      flash[:success] = 'ユーザーのアップデートが成功しました。'
      redirect_to user_path
    else
      flash[:warning] = 'ユーザーのアップデートが失敗しました。'
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    unless @user.is_created_by_user?(current_user)
      flash[:danger] = '他のユーザーの情報は編集できません。'
      redirect_to users_path
    end
    if @user.destroy
      flash[:success] = 'ユーザーが削除されました。'
      redirect_to users_path
    else
      flash[:warning] = 'ユーザーの削除に失敗しました。'
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :sex)
  end
end
