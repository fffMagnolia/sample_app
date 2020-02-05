require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  test "login with invalid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: '', password: '' } }
    # ログインページが再表示されることを期待
    assert_template 'sessions/new'
    # フラッシュメッセージが表示されることを期待
    assert_not flash.empty?
    get root_path
    # フラッシュメッセージが消えていることを期待
    assert flash.empty?
  end
end
