class Company < ApplicationRecord
  belongs_to :account
  belongs_to :user # Comapany admin or creator
  has_many :jobs, dependent: :destroy # Jobs associated with the company
end
