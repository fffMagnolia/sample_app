class UsersController < ApplicationController

  # 暗黙の了解でshow=/user/1対応
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new(params[:user])
  end

  def create
    @user = User.new()
    if @user.save
    else
      render 'new'
    end
  end
end
