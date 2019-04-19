class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      redirect_to(:users, notice: 'ログイン成功')
    else
      flash.now[:alert] = 'ログイン失敗'
      render action: 'new'
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: 'ログアウトしました!'
  end
end
