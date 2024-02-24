class Request < ApplicationRecord
  belongs_to :user


  validates :title, presence: true
  validates :description, length: { maximum: 200 }

  after_initialize :set_initial_approval

  scope :pending_approval, -> { where(approval: '承認待ち') }
  scope :approved, -> { where(approval: '承認済み') }
  scope :rejected, -> { where(approval: '拒否済み') }

  def set_initial_approval
    self.approval ||= '承認待ち'
  end

  def approve!
    self.update_columns(approval: '承認済み')
  end

  def reject!
    self.update_columns(approval: '拒否済み')
  end
end
