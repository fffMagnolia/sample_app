require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    # 誤データ送信後にカウントが増えないのが成功
    assert_no_difference 'User.count' do
      post users_path, params: {
        user: {
          name: "",
          email: "user@invalid",
          password: "foo",
          password_confirmation: "bar"
        }
      }
    end
    assert_template 'users/new'
    # エラ〜メッセージのテストもする
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path
    # オプションで増加前後の差異を渡す
    assert_difference 'User.count', 1 do
      post users_path, params: {
        user: {
          name: "Example User",
          email: "user@example.com",
          password: "password",
          password_confirmation: "password"
        }
      }
    end
    # https://edgeapi.rubyonrails.org/classes/ActionDispatch/Integration/RequestHelpers.html#method-i-follow_redirect-21
    # リダイレクト後リクエストを行う際に必要
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
