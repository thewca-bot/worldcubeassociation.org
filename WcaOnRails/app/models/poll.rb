class Poll < ActiveRecord::Base

  has_many :poll_options, foreign_key: "poll_id"
  has_many :votes, through: :poll_options

  validates :question, presence: true  
  validate :deadline_cannot_be_in_the_past#, :multiple_is_yes_no

  def deadline_cannot_be_in_the_past
    if deadline.present? && deadline < Date.today
      errors.add(:deadline, "can't be in the past")
    end
  end

end
