class IncomeTaxCalculator
  def initialize(incomes)
    @incomes = incomes
    @verbose = Rails.env.development?
    @brackets = Rails.application.config_for(:brackets)
    @brackets.transform_keys! { |key| key.to_s.to_i }
    @taxes = []
  end

  def call
    @incomes.each do |income_total|
      tax_total = 0
      taxed_income = 0
      puts "Income: #{income_total}" if @verbose
      @brackets.each_with_index do |bracket, index|
        if income_total > bracket[0] && index != @brackets.size - 1
          amount_to_tax = (bracket[0] - taxed_income)
        else
          amount_to_tax = (income_total - taxed_income)
        end
        bracket_tax = (amount_to_tax * bracket[1]) / 100
        tax_total += bracket_tax
        taxed_income += amount_to_tax

        # puts "-- Bracket #{bracket[0]}" if @verbose
        # puts "---> $#{amount_to_tax} % #{bracket[1]} , -> $#{bracket_tax}" if @verbose

        break if taxed_income == income_total
      end
      puts "-> TOTAL tax: $#{tax_total}" if @verbose
      @taxes << { income: income_total, tax: tax_total }
    end

    @taxes
  end
end
