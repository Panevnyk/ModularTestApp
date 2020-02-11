//
//  HabitAnalyticsInteractor.swift
//  BusinessLogic
//
//  Created by Vladyslav Panevnyk on 10.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

public enum HabitAnalyticsTimePeriod {
    case sinceStart
    case month(Date)
    case year(Date)
}

public protocol HabitAnalyticsInteractorInput {
    func loadHabitAnalytics(by timePeriod: HabitAnalyticsTimePeriod)
}

public protocol HabitAnalyticsInteractorOutput {
    func display(habitAnalytics habitDatas: [HabitData], by timePeriod: HabitAnalyticsTimePeriod)
}

public protocol HabitAnalyticsInteractorDBBoundary {

}

public class HabitAnalyticsInteractor: HabitAnalyticsInteractorInput {
    // MARK: - Properties
    private let output: HabitAnalyticsInteractorOutput
    private let habitAnalyticsDB: HabitAnalyticsInteractorDBBoundary
    private let habit: Habit
    private let currentDate: Date

    // MARK: - Inits
    public init(output: HabitAnalyticsInteractorOutput,
                habitAnalyticsDB: HabitAnalyticsInteractorDBBoundary,
                habit: Habit,
                currentDate: Date) {

        self.output = output
        self.habitAnalyticsDB = habitAnalyticsDB
        self.habit = habit
        self.currentDate = currentDate
    }
}

// MARK: - Public
public extension HabitAnalyticsInteractor {
    func loadHabitAnalytics(by timePeriod: HabitAnalyticsTimePeriod) {
        let habitDatas = getHabitDatas(by: timePeriod)
        output.display(habitAnalytics: habitDatas, by: timePeriod)
    }

    func getHabitDatas(by timePeriod: HabitAnalyticsTimePeriod) -> [HabitData] {
        switch timePeriod {
        case .sinceStart:
            return getHabitDatasSinceStart()
        case .month(let date):
            return getMonthHabitDatas(by: date)
        case .year(let date):
            return getYearHabitDatas(by: date)
        }
    }

    func getHabitDatasSinceStart() -> [HabitData] {
        return habit.habitDatas
    }

    func getMonthHabitDatas(by monthDate: Date) -> [HabitData] {
        guard currentDate >= monthDate else { return [] }
        return habit.habitDatas.filter { $0.date >= monthDate.startOfMonth && $0.date <= monthDate.endOfMonth }
    }

    func getYearHabitDatas(by yearDate: Date) -> [HabitData] {
        guard currentDate >= yearDate else { return [] }
        return habit.habitDatas.filter { $0.date >= yearDate.startOfYear && $0.date <= yearDate.endOfYear }
    }
}
