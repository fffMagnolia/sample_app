module SessionsHelper
  # =====================================
  # このヘルパーはapplication controllerにincludeされているので
  # 全てのcontrollerから呼び出し可能
  # =====================================

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

  # 通常、falseを期待
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def remember
    user.remember
    # signdで暗号化される
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
end
