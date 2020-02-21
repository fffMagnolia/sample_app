require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    # users.ymlからfixtureを呼び出す
    @user = users(:michael)
  end

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

  test "login with valid information" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    # ユーザの個別ページにリダイレクトすることを期待
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0 
    assert_select "a[href=?]", logout_path 
    assert_select "a[href=?]", user_path(@user)

  end
end
