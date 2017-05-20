class Office < ApplicationRecord
  has_many :workers

  validates :name, uniqueness: true
end
