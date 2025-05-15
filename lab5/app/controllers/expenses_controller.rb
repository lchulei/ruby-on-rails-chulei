class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @expenses = Expense.all
  end

  def show; end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    if @expense.save
      redirect_to @expense, notice: 'Витрата створена успішно.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @expense.update(expense_params)
      redirect_to @expense, notice: 'Витрату оновлено.'
    else
      render :edit
    end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_path, notice: 'Витрату видалено.'
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:amount, :description, :spendAt, category_ids: [], payment_method_ids: [])
  end
end
