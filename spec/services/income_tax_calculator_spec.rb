# frozen_string_literal: true

require 'spec_helper'

RSpec.describe IncomeTaxCalculator do
  let(:incomes) { [0] }
  let(:subject) { IncomeTaxCalculator.new(incomes).call }

  describe '#call' do
    it 'calculates tax and returns an oject with total and tax' do
      expect(subject).to eq([{ income: incomes[0], tax: 0 }])
    end

    context 'with an array of incomes' do
      let(:incomes) { [10_000, 20_000, 30_000, 40_000, 55_000] }
      it 'calculates tax and returns an oject with total and tax' do
        expect(subject).to eq([
                                { income: incomes[0], tax: 0 },
                                { income: incomes[1], tax: 1000 },
                                { income: incomes[2], tax: 3000 },
                                { income: incomes[3], tax: 5000 },
                                { income: incomes[4], tax: 8500 }\
                              ])
      end
    end
  end
end
