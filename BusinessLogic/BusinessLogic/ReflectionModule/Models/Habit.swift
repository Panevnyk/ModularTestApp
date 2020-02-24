//
//  Habit.swift
//  BusinessLogic
//
//  Created by Vladyslav Panevnyk on 28.01.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

public struct Habit {
    public var habitTitle: String
    public var creationDate: Date
    public var timePeriod: HabitTimePeriod
    public var schedule: [HabitScheduleDay]
    public var habitDataType: HabitDataType
    public var habitDatas: [HabitData]

    public init(habitTitle: String,
                creationDate: Date = Date(),
                timePeriod: HabitTimePeriod,
                schedule: [HabitScheduleDay] = HabitScheduleDay.allCases,
                habitDataType: HabitDataType,
                habitDatas: [HabitData]) {

        self.habitTitle = habitTitle
        self.creationDate = creationDate
        self.timePeriod = timePeriod
        self.schedule = schedule
        self.habitDataType = habitDataType
        self.habitDatas = habitDatas
    }

    public func canAddedHabitData(_ habitData: HabitData) -> Bool {
        switch habitDataType {
        case .boolean:
            return habitData.value is Bool
        case .range:
            return habitData.value is Int
        case .description:
            return habitData.value is String
        }
    }

    public static func makeEmptyInstance() -> Habit {
        return Habit(habitTitle: "",
                     creationDate: Date(),
                     timePeriod: .day,
                     schedule: HabitScheduleDay.allCases,
                     habitDataType: .boolean,
                     habitDatas: [])
    }
}

public enum HabitScheduleDay: Int, CaseIterable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}

public enum HabitTimePeriod: Int, CaseIterable {
    case day
    case week
    case month

    public var title: String {
        switch self {
        case .day:
            return "Day"
        case .week:
            return "Week"
        case .month:
            return "Month"
        }
    }
}

public enum HabitDataType: Int {
    case boolean
    case range
    case description
}

extension Habit: Equatable {
    public static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.habitTitle == rhs.habitTitle
            && lhs.creationDate == rhs.creationDate
            && lhs.timePeriod == rhs.timePeriod
            && lhs.habitDataType == rhs.habitDataType
            && lhs.habitDatas == rhs.habitDatas
    }
}
