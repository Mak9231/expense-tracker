class AddCategoryToExpenses < ActiveRecord::Migration[7.2]
  def change
    add_reference :expenses, :category, null: true, foreign_key: true
  end
end
