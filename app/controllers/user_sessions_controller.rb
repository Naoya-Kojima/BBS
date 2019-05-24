class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = login(params[:email], params[:password])
    if @user
      flash[:success] = 'ログイン成功'
      redirect_to(:users)
    else
      flash[:warning] = 'ログイン失敗'
      render action: 'new'
    end
  end

  def destroy
    logout
    flash[:info] = 'ログアウトしました！'
    redirect_to root_url
  end
end
