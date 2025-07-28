class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :account
  has_many :companies
  has_many :jobs
  has_many :applications, dependent: :destroy
  enum :role, super_admin: 0, company_admin: 1, applicant: 2
end
