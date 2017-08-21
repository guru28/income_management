class IncomesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_income, only: [:show, :edit, :update, :destroy]

  def index
    @incomes = current_user.incomes
    @categories = current_user.categories.income
  end

  def show
  end

  def new
    @income = Income.new
    @categories = current_user.categories.income
    @income.build_payment
  end

  def reports
    @incomes = current_user.incomes.joins(:payment)
    @expences = current_user.expences.joins(:payment)
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf => "reports", :layout => 'pdf.html'
      end
    end
  end

  def edit
    @payment = @income.payment
    @categories = current_user.categories.income
  end

  def create
    @income = Income.new(income_params)
    @income.build_payment(payment_params)
    @income.save
    respond_to do |format|
      puts @income.payment.inspect
      if @income.payment.present?
        format.html { redirect_to @income, notice: 'Income was successfully created.' }
        format.json { render :show, status: :created, location: @income }
      else
        puts @income.payment.errors.inspect
        format.html { render :new }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @income.payment.update(payment_params)
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
      params.require(:income).permit(:user_id)
    end

    def payment_params
      params.require(:payment).permit(:name, :amount, :category_id)
    end
end
