class Position < ApplicationRecord
  has_many :users, dependent: :restrict_with_error

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
