class Worker < ApplicationRecord
  belongs_to :office

  validates :name, uniqueness: true
end
