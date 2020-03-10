class BracketMaxCalculator
  def initialize(incomes)
    @incomes = incomes
    @brackets = Rails.application.config_for(:brackets)
    @brackets.each do |b|
      binding.pry
    end
    # binding.pry
  end

  def call
    @incomes.each do |income_total|
      tax_total = 0
      untaxxed_income = income_total
      @brackets.each do |bracket|
        if income_total > bracket[0] 
      end
    end
  end
end

# IncomeTaxCalculator.new(1).call