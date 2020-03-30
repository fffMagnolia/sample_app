class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

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
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      # url: 完全パスを返す
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # --- before action ---
    def logged_in_user
      if logged_in? == false
        store_location
        flash[:danger] = 'Please logged in.'
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id])
      # call helper method
      if !current_user?(@user)
        redirect_to(root_url)
      end
    end
end
