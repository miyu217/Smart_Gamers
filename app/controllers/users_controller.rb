class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @game = Game.find(params[:id])
    @latest_review = @user.reviews.last
  end

  def index
    @users = User.all
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     redirect_to user_path(@user), notice: "ユーザー情報を編集しました！"
    else
     render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction, :admin)
  end
end
