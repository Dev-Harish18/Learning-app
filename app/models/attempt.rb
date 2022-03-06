class Attempt < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  has_many :attempted_questions
end
