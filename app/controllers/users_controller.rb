class UsersController < ApplicationController

  # 暗黙の了解でshow=/user/1対応
  def show
    @user = User.find(params[:id])
  end

  def new
  end
end
