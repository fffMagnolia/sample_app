class UsersController < ApplicationController

  # 暗黙の了解でshow=/user/1対応
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # セキュリティ上、一度privateメソッドを通してから保存する
    @user = User.new(user_params)
    if @user.save
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
