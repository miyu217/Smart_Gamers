class Game < ApplicationRecord
  belongs_to :user
  has_many :favorites
  has_many :favorited_by, through: :favorites, source: :user
  has_many :reviews, dependent: :destroy

  validates :title, presence: true
  validates :status, inclusion: { in: %w(ios android), message: "はiOSまたはAndroidである必要があります" }
  validates :genre, presence: true
  validates :release_date, presence: true
  validates :developer, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.looks(search, word)
    if search == "perfect_match"
      @game = Game.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @game = Game.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @game = Game.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @game = Game.where("title LIKE?","%#{word}%")
    else
      @game = Game.all
    end
  end
end
