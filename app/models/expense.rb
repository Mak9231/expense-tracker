class Expense < ApplicationRecord
  belongs_to :category

  attr_accessor :category_name

  before_validation :assign_category_by_name

  def assign_category_by_name
    if category_name.present?
    self.category = Category.find_or_create_by(name: category_name.strip)
    end
  end
end
