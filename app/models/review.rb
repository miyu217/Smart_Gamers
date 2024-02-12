class Review < ApplicationRecord
  belongs_to :user
  belongs_to :game

  validates :seriousness_rating, presence: true
  validates :package_name, presence: true
  validates :spent_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :rating, presence: true
  validates :comment, presence: true, length: { maximum: 200 }

  def voted_for?(user)
    ReviewVote.exists?(user: user, review: self)
  end
end
