class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @game = Game.find(params[:game_id])
    current_user.favorites.create(game: @game) unless current_user.favorited?(@game)
    redirect_to games_path, notice: 'お気に入り登録が完了しました!'
  end

  def destroy
    @game = Game.find(params[:game_id])
    @favorite = current_user.favorites.find_by(game: @game)
    @favorite.destroy if @favorite
    redirect_to game_path(@game), alert: 'ゲームをお気に入りから削除しました'
  end
end
