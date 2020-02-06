module SessionsHelper
  # email&passwordでの認証後呼び出される
  def log_in(user)
    # session: Railsの組み込みメソッド
    session[:user_id] = user.id
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end
end
