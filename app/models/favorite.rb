class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :user_id, uniqueness: { scope: :game_id, message: "はすでにお気に入り登録されています" }
end
