# =====================================
# controller側のヘルパーをテストで呼び出すことはできないので、
# ここに再定義する
# =====================================
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # sessions helperのlogged_in?と同じ動作
  def is_logged_in?
    !session[:user_id].nil?
  end
end
