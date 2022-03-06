class Grade < ApplicationRecord
  belongs_to :board,optional:true
  has_many :subjects
end
