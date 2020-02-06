module SessionsHelper
  # email&passwordでの認証後呼び出される
  def log_in(user)
    # session: Railsの組み込みメソッド
    session[:user_id] = user.id
  end
end
