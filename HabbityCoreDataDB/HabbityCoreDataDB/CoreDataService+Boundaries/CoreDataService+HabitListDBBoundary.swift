//
//  CoreDataService+HabitListDBBoundary.swift
//  HabbityCoreDataDB
//
//  Created by Vladyslav Panevnyk on 20.07.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import CoreData
import HabbityDomain

// MARK: - HabitListDBBoundary
extension CoreDataService: HabitListDBBoundary {
    public func getAllHabits(completion: ((_ : [Habit]) -> Void)?) {
        getEntities { [weak self] (habitsMO: [HabitMO]?) in
            guard let self = self else { completion?([]); return }

            let habits = habitsMO?.compactMap { self.makeHabit(from: $0) } ?? []
            completion?(habits)
        }
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
private extension HabitScheduleDay {
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
