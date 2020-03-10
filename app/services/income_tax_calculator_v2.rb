class IncomeTaxCalculatorV2 < IncomeTaxCalculator
  def initialize(incomes)
    super
    @calculated_brackets = {}
    calculate_bracket_increments
  end

  def calculate_bracket_increments
    taxed_amount = 0
    accumulated_tax = 0
    @brackets.each do |bracket|
      @calculated_brackets[bracket[0]] = {
        tax: bracket[1],
        previous_bracket_total_tax: accumulated_tax,
        already_taxed_amount: taxed_amount
      }

      bracket_tax = ((bracket[0] - taxed_amount) * bracket[1]) / 100
      taxed_amount = bracket[0]
      accumulated_tax += bracket_tax
    end
    @calculated_brackets.freeze
  end

  def call
    @incomes.each do |income_total|
      puts "Income: #{income_total}" if @verbose
      bracket = @calculated_brackets.find { |bracket| bracket[0] > income_total }
      bracket ||= [income_total, @calculated_brackets[@calculated_brackets.keys.last]]

      bracket_tax = ((income_total - bracket[1][:already_taxed_amount]) * bracket[1][:tax]) / 100
      tax_total = bracket[1][:previous_bracket_total_tax] + bracket_tax

      puts "-> TOTAL tax: $#{tax_total}" if @verbose

      @taxes << { income: income_total, tax: tax_total }
    end
    @taxes
  end
end
