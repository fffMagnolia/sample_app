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

  test "login with valid information with followed by logout" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, password: 'password' } }
    assert is_logged_in?
    # ユーザの個別ページにリダイレクトすることを期待
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0 
    assert_select "a[href=?]", logout_path 
    assert_select "a[href=?]", user_path(@user)

    # ここからログアウト時のテスト
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    ##################
    # situation: 
    # 2つ以上のタブでサイトを開いている
    # 1つのタブでログアウト
    # 別のタブで再度ログアウト
    ##################
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end

  test "login with remembering" do
    log_in_as(@user)
    assert_not_empty cookies['remember_token']
  end

  test "login without remembering" do
    ##################
    # flow
    # cookieを保存してログイン
    # ログアウト
    # cookieを削除してログイン
    # 以前のcookieが消えていることを確認
    ##################
    # remember_meは省略可能(デフォルトで1)
    log_in_as(@user)
    delete logout_path
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end
end
