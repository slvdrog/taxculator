class IncomeTaxesController < ApplicationController

  def index

  end

  def calculate
    IncomeTaxCalculator.new(income_params).call
  end

  private

  def income_params
    params.require(:incomes).chomp.split().map{|e| e.to_f}
  end
end
