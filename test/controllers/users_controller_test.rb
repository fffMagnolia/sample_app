require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: {
      user: {
        name: @user.name,
        email: @user.email
      }
    }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "shold redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    # 恐らく下記は不要
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirected update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: {
      user: {
        name: @user.name,
        email: @user.email
      }
    }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  # NOTE:このテストは演習にあるもの
  test "should not allow the admin attribute to edited via the web" do
    log_in_as(@user)
    # falseであることを期待
    assert_not @other_user.admin?
    # adminの変更が不可であることを期待
    patch user_path(@other_user), params: {
      user: {
        password: '',
        password_digest: '',
        admin: true
      }
    }
    assert_not @other_user.reload.admin?
  end

  # ログインしていないユーザが削除できないことを期待
  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  # 管理者以外は削除できないことを期待
  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end 
end
