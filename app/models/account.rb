class Account < ApplicationRecord
  has_many :users
  has_many :companies
  has_many :jobs
end
