# =====================================
# controller側のヘルパーをテストで呼び出すことはできないので、
# ここに再定義する
# =====================================

ENV['RAILS_ENV'] ||= 'test'

class ActiveSupport::TestCase
  fixtures :all

  # sessions helperのlogged_in?と同じ動作
  def is_logged_in?
    !session[:user_id].nil?
  end
end