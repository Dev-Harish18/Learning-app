class Content < ApplicationRecord
  belongs_to :chapter
  has_many :user_contents
end
