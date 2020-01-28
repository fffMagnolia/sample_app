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
end
