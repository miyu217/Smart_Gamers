class GamesController < ApplicationController
  before_action :authenticate_admin, except: [:index, :show, :search]
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  def create
    @game = Game.new(game_params)
    @game.user_id = current_user.id
    if @game.save
      flash[:notice]= "ゲームを追加しました！"
      redirect_to game_path(@game)
    else
      @games = Game.all
      @user = User.find(current_user.id)
      render "index"
    end
  end

  def index
    @games = Game.all
    @user = User.find(current_user.id)
    @game = Game.new
  end

  def show
    @user = @game.user

  end

  def edit
    if @game.user == current_user
      render "edit"
    else
      redirect_to games_path
    end
  end

  def update
    @game.user_id = current_user.id
    if @game.update(game_params)
      flash[:notice]= "ゲーム情報を編集しました！！"
      redirect_to game_path(@game.id)
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path
  end

  def search
    @query = params[:query]
    @games = Game.where("title LIKE ? OR genre LIKE ?", "%#{@query}%", "%#{@query}%")
    @user = User.find(current_user.id)
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    params.require(:game).permit(:title, :status, :genre, :release_date, :developer, :price, :payment_details)
  end

  def authenticate_admin
    redirect_to root_path, alert: 'アクセス権限がありません。' unless current_user&.admin?
  end
end
