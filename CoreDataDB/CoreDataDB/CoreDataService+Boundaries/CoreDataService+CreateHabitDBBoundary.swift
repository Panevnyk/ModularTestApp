//
//  CreateHabitDBBoundary.swift
//  CoreDataDB
//
//  Created by Vladyslav Panevnyk on 14.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import CoreData
import Domain

// MARK: - CreateHabitDBBoundary, HabitListDBBoundary
extension CoreDataService: CreateHabitDBBoundary, HabitListDBBoundary {
    public func addHabit(_ habit: Habit) {
        let habitMO = makeHabitMO(from: habit, backgroundContext: backgroundContext)
        save(object: habitMO)
    }

    public func getAllHabits() -> [Habit] {
        let habitsMO: [HabitMO] = getEntities() ?? []
        return habitsMO.compactMap { makeHabit(from: $0) }
    }

    public func remove(habit: Habit) -> Bool {
        guard let habitMOForRemove = fetchPlaceMOFromDB(by: habit, backgroundContext: backgroundContext) else { return false }
        remove(object: habitMOForRemove)
        return true
    }

    private func fetchPlaceMOFromDB(by habit: Habit, backgroundContext: NSManagedObjectContext) -> HabitMO? {
        let predicate = NSPredicate(format: "id = %@", habit.id.uuidString)
        do {
            return try backgroundContext.entity(withType: HabitMO.self, predicate: predicate)
        } catch let error {
            print("CoreDataService module fail to fetch habit object error: \(error)")
        }
        return nil
    }
}

// MARK: - Transform Habit to HabitMO
private extension CoreDataService {
    func makeHabitMO(from habit: Habit, backgroundContext: NSManagedObjectContext) -> HabitMO {
        let habitMO = HabitMO(context: backgroundContext)
        habitMO.id = habit.id
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
        let habitDataMO = HabitDataMO(context: backgroundContext)
        habitDataMO.id = habitData.id
        habitDataMO.value = habitData.value as? String
        habitDataMO.date = habitData.date
        return habitDataMO
    }
}

// MARK: - Transform HabitMO to Habit
private extension CoreDataService {
    func makeHabit(from habitMO: HabitMO) -> Habit? {
        guard let id = habitMO.id,
            let habitTitle = habitMO.habitTitle,
            let creationDate = habitMO.creationDate,
            let timePeriod = HabitTimePeriod(rawValue: Int(habitMO.timePeriod)),
            let habitDataType = HabitDataType(rawValue: Int(habitMO.habitDataType)) else { return nil }

        return Habit(id: id,
                     habitTitle: habitTitle,
                     creationDate: creationDate,
                     timePeriod: timePeriod,
                     schedule: HabitScheduleDay.scheduleRepresentable(from: habitMO.schedule),
                     habitDataType: habitDataType,
                     habitDatas: makeHabitDatas(from: habitMO.habitDatas))
    }

    func makeHabitDatas(from habitDataMOSet: NSSet?) -> [HabitData] {
        guard let habitDataMOArray = habitDataMOSet?.allObjects as? [HabitDataMO] else { return [] }
        return habitDataMOArray.compactMap { makeHabitData(from: $0) }
    }

    func makeHabitData(from habitDataMO: HabitDataMO) -> HabitData? {
        guard let id = habitDataMO.id,
            let value = habitDataMO.value,
            let date = habitDataMO.date else { return nil }

        return HabitData(id: id,
                         value: value,
                         date: date)
    }
}

// MARK: - HabitScheduleDay helpers
fileprivate extension HabitScheduleDay {
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

    static func scheduleRepresentable(from string: String?) -> [HabitScheduleDay] {
        guard let string = string else { return [] }
        var schedule: [HabitScheduleDay] = []

        HabitScheduleDay.allCases.forEach { habitScheduleDay in
            if string.contains(String(habitScheduleDay.rawValue)) {
                schedule.append(habitScheduleDay)
            }
        }

        return schedule
    }
}
