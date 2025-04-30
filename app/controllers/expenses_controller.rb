require 'groupdate'
require 'csv'
class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[show edit update destroy]

# GET /expenses
def index
  @expenses = Expense.all
  @expenses_by_category = Expense.group(:category).sum(:amount)
  @total_amount = @expenses.sum(:amount)
  # @expenses_by_date = Expense.group_by_day(:date).sum(:amount)#je remplace cette ligne par le bloc en dessous
  expenses_scope = Expense.all

if params[:start_date].present?
  expenses_scope = expenses_scope.where("date >= ?", params[:start_date])
end

if params[:end_date].present?
  expenses_scope = expenses_scope.where("date <= ?", params[:end_date])
end

@expenses_by_date = expenses_scope.group_by_day(:date).sum(:amount)


  respond_to do |format|
    format.html  # Rendre la vue HTML normale
    format.js { render :index }  # Rendre la vue index.js.erb quand c'est un appel AJAX
  end

  if params[:query].present?
    @expenses = @expenses.where("title ILIKE ?", "%#{params[:query]}%")
  end

  if params[:start_date].present?
    @expenses = @expenses.where("date >= ?", params[:start_date])
  end

  if params[:end_date].present?
    @expenses = @expenses.where("date <= ?", params[:end_date])
  end

  if params[:category].present? && params[:category] != "Toutes"
    @expenses = @expenses.where(category: params[:category])
  end

  if params[:sort] == "amount"
    @expenses = @expenses.order(amount: :desc)
  elsif params[:sort] == "date"
    @expenses = @expenses.order(date: :desc)
  else
    @expenses = @expenses.order(created_at: :desc)
  end
end

def export
  @expenses = Expense.all

  # Créer le fichier CSV
  csv_data = CSV.generate(headers: true) do |csv|
    csv << ["Title", "Amount", "Date", "Category"]  # En-têtes du CSV

    @expenses.each do |expense|
      csv << [expense.title, expense.amount, expense.date, expense.category]
    end
  end

  # Télécharger le fichier CSV
  send_data csv_data, filename: "expenses-#{Date.today}.csv", type: "text/csv"
end


  # GET /expenses/1
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # POST /expenses
  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to @expense, notice: 'Expense was successfully created.'
    else
      render :new
    end
  end

  # GET /expenses/1/edit
  def edit
  end

  # PATCH/PUT /expenses/1
  def update
    if @expense.update(expense_params)
      redirect_to @expense, notice: 'Expense was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /expenses/1
  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_path, notice: "Dépense supprimée avec succès." }
      format.json { head :no_content }
    end
  end

  private
    def set_expense
      @expense = Expense.find(params[:id])
    end

    def expense_params
      params.require(:expense).permit(:title, :amount, :date, :category_name)
    end
end


# def destroy
#   @expense.destroy
#   redirect_to expenses_url, notice: 'Expense was successfully destroyed.'
# end





# def index
#   @expenses = Expense.all

#   if params[:query].present?
#     @expenses = @expenses.where("title LIKE ?", "%#{params[:query]}%")
#   end

#   if params[:start_date].present?
#     @expenses = @expenses.where("date >= ?", params[:start_date])
#   end

#   if params[:end_date].present?
#     @expenses = @expenses.where("date <= ?", params[:end_date])
#   end

#   @expenses_by_date = Expense.group_by_day(:date).sum(:amount)
#   @total_amount = @expenses.sum(:amount)

#   respond_to do |format|
#     format.html  # Rendre la vue HTML normale
#     format.js { render :index }  # Rendre la vue index.js.erb quand c'est un appel AJAX
#   end
# end
