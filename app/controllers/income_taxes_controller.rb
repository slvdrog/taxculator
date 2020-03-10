class IncomeTaxesController < ApplicationController
  def index
  end

  def calculate
    @results = IncomeTaxCalculator.new(income_params).call
    # IncomeTaxCalculatorV2.new(income_params).call
  end

  private

  def income_params
    params.require(:incomes).chomp.split.map(&:to_f)
  end
end
