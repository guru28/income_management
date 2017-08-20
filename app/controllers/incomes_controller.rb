class IncomesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_income, only: [:show, :edit, :update, :destroy]

  def index
    @incomes = current_user.incomes
  end

  def show
  end

  def new
    @income = Income.new
    @categories = Category.all.income
  end

  def reports
    @incomes = current_user.incomes
    @expences = current_user.expences
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "reports", :layout => 'pdf.html'
      end
    end
  end

  def edit
    @categories = Category.all.income
  end

  def create
    @income = Income.new(income_params)

    respond_to do |format|
      if @income.save
        format.html { redirect_to @income, notice: 'Income was successfully created.' }
        format.json { render :show, status: :created, location: @income }
      else
        format.html { render :new }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @income.update(income_params)
        format.html { redirect_to @income, notice: 'Income was successfully updated.' }
        format.json { render :show, status: :ok, location: @income }
      else
        format.html { render :edit }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @income.destroy
    respond_to do |format|
      format.html { redirect_to incomes_url, notice: 'Income was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_income
      @income = Income.find(params[:id])
    end

    def income_params
      params.require(:income).permit(:name, :amount, :user_id, :category_id)
    end
end
