class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User

  belongs_to :department
  belongs_to :position

  validates :name, :address, :salary, :start_date, presence: true
  validates :phone, :email, presence: true, uniqueness: { case_sensitive: false }
end
