class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(user_id: params[:user_id])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to photos_path
    else
      if params[:user_id].empty? && params[:password].empty?
        flash[:alert] = "・ユーザーIDを入力してください"
        flash[:alert] << "<br>・パスワードを入力してください"
      elsif params[:user_id].empty?
        flash[:alert] = "・ユーザーIDを入力してください"
      elsif params[:password].empty?
        flash[:alert] = "・パスワードを入力してください"
      else
        flash[:alert] = "ユーザー名とパスワードが一致しません"
      end

      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    session[:code] = nil
    session[:access_token] = nil

    flash[:notice]="Logged Out"
    redirect_to login_path
  end
end
