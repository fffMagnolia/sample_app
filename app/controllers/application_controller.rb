class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # 全てのコントローラからSessionsHelperが使用可能になる
  include SessionsHelper
end