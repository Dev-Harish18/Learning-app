class Board < ApplicationRecord
	has_many :users
	has_many :grades
end
