class Exercise < ApplicationRecord
  belongs_to :chapter
  has_many :questions
end
