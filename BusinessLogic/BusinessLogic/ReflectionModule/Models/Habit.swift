//
//  Habit.swift
//  BusinessLogic
//
//  Created by Vladyslav Panevnyk on 28.01.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

public struct Habit {
    public var habitTitle: String
    public var habitDataType: HabitDataType
    public var habitDatas: [HabitData]

    func canAddedHabitData(_ habitData: HabitData) -> Bool {
        switch habitDataType {
        case .boolean:
            return habitData.value is Bool
        case .counting:
            return habitData.value is Int
        case .range:
            return habitData.value is Int
        case .time:
            return habitData.value is Date
        case .description:
            return habitData.value is String
        }
    }
}

public enum HabitDataType {
    case boolean
    case counting
    case range
    case time
    case description
}

extension Habit: Equatable {
    public static func == (lhs: Habit, rhs: Habit) -> Bool {
        return lhs.habitTitle == rhs.habitTitle
            && lhs.habitDataType == rhs.habitDataType
            && lhs.habitDatas == rhs.habitDatas
    }
}
