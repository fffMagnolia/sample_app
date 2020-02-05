class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 全てのコントローラからSessionHelperが使用可能になる
  include SessionHelper
end