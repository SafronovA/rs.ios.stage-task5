import Foundation

class StockMaximize {

    func countProfit(prices: [Int]) -> Int {
        let days: Int = prices.count
        var profit = 0
        for i in 0..<days {
            var maxDiff = 0
            for k in i + 1..<days{
                let diff = prices[k] - prices[i]
                if (diff > maxDiff){
                    maxDiff = diff}
            }
            profit += maxDiff
        }
        return profit
    }
}
