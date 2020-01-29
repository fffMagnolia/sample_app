class UsersController < ApplicationController

  # 暗黙の了解でshow=/user/1対応
  def show
    @user = User.find(params[:id])
  end

  def new
    # POST処理に必要なインスタンス変数を生成
    @user = User.new
  end

  def create
    # newアクションで生成したインスタンス変数からパラメータを受け取ってインスタンス変数を生成
    # セキュリティ上、一度privateメソッドを通してから保存する
    @user = User.new(user_params)
    if @user.save
      # url: 完全パスを返す
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
