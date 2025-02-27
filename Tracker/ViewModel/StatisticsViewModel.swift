//
//  StatisticsViewModel.swift
//  Tracker
//
//  Created by Varvara Kiseleva on 02.12.2024.
//

import Foundation

final class StatisticsViewModel {
    private let statisticsStore: StatisticsProtocol
    
    init(statisticsStore: StatisticsProtocol = StatisticsStore()) {
        self.statisticsStore = statisticsStore
    }
    
    func getStatisticsItems() -> [StatisticsItem] {
        self.statisticsStore.loadData()
        let items = [
            (value: statisticsStore.countBestPeriod(), description: LocalizedString.Statistic.bestPeriod),
            (value: statisticsStore.countPerfectDays(), description: LocalizedString.Statistic.perfectDays),
            (value: statisticsStore.countCompletedTrackers(), description: LocalizedString.Statistic.trackersCompleted),
            (value: statisticsStore.getAverageValue(), description: LocalizedString.Statistic.averageValue)
        ]
        
        let count = items
            .filter { $0.value > 0 }
            .count
        
        if count > 0  {
            return items.map { StatisticsItem(value: "\($0.value)", description: $0.description) }
        }
        
        return []
    }
}
