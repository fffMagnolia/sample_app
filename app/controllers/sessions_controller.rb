class SessionsController < ApplicationController
  # ログインページにアクセスした時のアクション
  def new
  end

  # ログイン情報を送信した時のアクション
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # authenticate: has_secure_passwordを追加することにより提供されるメソッド
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      # ログイン後ユーザページに遷移する
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email or password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
