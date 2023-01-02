class Studio < ApplicationRecord
  has_many :movies
  has_many :actors, through: :movies
end
