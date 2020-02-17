//
//  CreateHabitDBBoundary.swift
//  CoreDataDB
//
//  Created by Vladyslav Panevnyk on 14.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import CoreData
import BusinessLogic

extension CoreDataService: CreateHabitDBBoundary {
    public func addHabit(_ habit: Habit) {
        let habitMO = makeHabitMO(from: habit, backgroundContext: backgroundContext)
        save(object: habitMO)
    }
}

// MARK: - Helper methods
private extension CoreDataService {
    func makeHabitMO(from habit: Habit, backgroundContext: NSManagedObjectContext) -> HabitMO {
        let habitMO = HabitMO()
        habitMO.habitTitle = habit.habitTitle
        habitMO.creationDate = habit.creationDate
        habitMO.timePeriod = Int64(habit.timePeriod.rawValue)
        habitMO.schedule = HabitScheduleDay.stringRepresentable(from: habit.schedule)
        habitMO.habitDataType = Int64(habit.habitDataType.rawValue)
        habitMO.habitDatas = makeHabitDataMOSet(from: habit.habitDatas,
                                                backgroundContext: backgroundContext)
        return habitMO
    }

    func makeHabitDataMOSet(from habitDatas: [HabitData], backgroundContext: NSManagedObjectContext) -> NSSet? {
        return NSSet(array:
            habitDatas.map { makeHabitDataMO(from: $0,
                                             backgroundContext: backgroundContext) })
    }

    func makeHabitDataMO(from habitData: HabitData, backgroundContext: NSManagedObjectContext) -> HabitDataMO {
        let habitDataMO = HabitDataMO()
        habitDataMO.id = habitData.id
        habitDataMO.value = habitData.value as? String
        habitDataMO.date = habitData.date
        return habitDataMO
    }
}

extension HabitScheduleDay {
    static func stringRepresentable(from schedule: [HabitScheduleDay]) -> String {
        var str = ""
        schedule.enumerated().forEach { value in
            str.append(String(value.element.rawValue))
            if value.offset < schedule.count - 1 {
                str.append(", ")
            }
        }
        return str
    }
}
