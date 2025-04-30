class Category < ApplicationRecord
  has_many :expenses, dependent: :nullify
end
