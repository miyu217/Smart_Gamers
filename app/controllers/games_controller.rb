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
