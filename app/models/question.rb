class Question < ApplicationRecord
  belongs_to :exercise
  has_many :attempted_questions
end
