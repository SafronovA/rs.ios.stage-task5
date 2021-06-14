import Foundation

public typealias Supply = (weight: Int, value: Int)

public final class Knapsack {
    let maxWeight: Int
    let drinks: [Supply]
    let foods: [Supply]
    var maxKilometers: Int {
        findMaxKilometres()
    }
    
    init(_ maxWeight: Int, _ foods: [Supply], _ drinks: [Supply]) {
        self.maxWeight = maxWeight
        self.drinks = drinks
        self.foods = foods
    }
    
    
    func findMaxKilometres() -> Int {
        if (maxWeight > 2500 && maxWeight < 0) {
            return 0
        }
        var maxKilometers = 0
        let foodsKnapsack = getKnapsack(of: foods)
        let drinksKnapsack = getKnapsack(of: drinks)
        for i in 0...maxWeight {
            maxKilometers = max(
                maxKilometers,
                min(foodsKnapsack[foods.count][i], drinksKnapsack[drinks.count][maxWeight - i])
            )
        }
        return maxKilometers
    }
    
    private func getKnapsack(of supply: [Supply]) -> [[Int]] {
        var knapsack = Array(repeating: Array(repeating: 0, count: maxWeight + 1), count: supply.count + 1)
        for i in 0...supply.count - 1{
            for k in 0...maxWeight {
                if supply[i].weight < k {
                    knapsack[i + 1][k] = max(
                        knapsack[i][k],
                        supply[i].value + knapsack[i][k - supply[i].weight]
                    )
                } else {
                    knapsack[i + 1][k] = knapsack[i][k]
                }
            }
        }
        return knapsack
    }
}
