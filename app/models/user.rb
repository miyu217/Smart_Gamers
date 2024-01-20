class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :games
  has_many :favorites
  has_many :favorite_games, through: :favorites, source: :game
  has_many :reviews, dependent: :destroy
  has_many :requests, dependent: :destroy

  def favorited?(game)
    favorite_games.exists?(id: game.id)
  end
end
