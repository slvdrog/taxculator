# Roostify Assignment

## Bracketed Tax Engine

I implemented two different approaches to calculating tax ,`IncomeTaxCalculator` and `IncomeTaxCalculatorV2`.

The bracket definition is done through `config/brackets.yml`

Both are iterative approaches, but the difference is that `v2` is much faster with huge batches of incomes to tax. It iterates over the brackets first and pre-calculates the accumulated tax for each stage. Then, when calculating the tax for each income only one multiplication needs to be done and then added to the accumulated totals.

The issue with v2 is that if there are a lot of brackets, and we just need to calculate one income, there are unneccesary calculations performed.

The choice between one or the other should be done considering the use cases of the engine, or we could implement a selector based on the amount of records to check.

### Scalability

This implementation already scales from a `# of brackets` and calculation perspective. If the batch is too big further improvements could be made.

* Moving the logic to a Background Job to handle batches of incomes.
  * Having one job per income would actually be detrimental, the calculation is too simple and it adds too much overhead, thus the batches.
  * This would imply serving the results through a mailer or using websockets to refresh the page as they come in.
* Identifying duplicate incomes and avoiding duplicate calculations(specially on big batches, on smaller ones this is actually worse)