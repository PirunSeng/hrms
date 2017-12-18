Rails.application.config.active_record.belongs_to_required_by_default = false

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable
  include DeviseTokenAuth::Concerns::User

  belongs_to :department
  belongs_to :position

  validates :name, :address, :salary, :start_date, presence: true
  validates :phone, presence: true, uniqueness: { case_sensitive: false }
end
