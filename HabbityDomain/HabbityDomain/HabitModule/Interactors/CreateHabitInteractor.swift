//
//  CreateHabitInteractor.swift
//  HabbityDomain
//
//  Created by Vladyslav Panevnyk on 11.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

public protocol CreateHabitInteractorInput: class {
    func setHabitTitle(_ habitTitle: String)
    func setCreationDate(_ creationDate: Date)
    func setTimePeriod(_ timePeriod: HabitTimePeriod)
    func setSchedule(_ schedule: [HabitScheduleDay])
    func setHabitDataType(_ habitDataType: HabitDataType)

    func canAddHabit() -> Bool
    func addHabit()
    func getHabit() -> Habit
}

public protocol CreateHabitInteractorOutput {
    func presentHabitAddedSuccessfuly()
    func presentHabitAddingFailure()
    func present(habit: Habit)
}

public protocol CreateHabitDBBoundary {
    func addHabit(_ habit: Habit)
}

public final class CreateHabitInteractor: CreateHabitInteractorInput {
    // MARK: - Properties
    private let output: CreateHabitInteractorOutput
    private let createHabitDB: CreateHabitDBBoundary
    private var habit: Habit

    // MARK: - Init
    public init(output: CreateHabitInteractorOutput,
                createHabitDB: CreateHabitDBBoundary,
                habit: Habit = Habit.makeEmptyInstance()) {
        self.output = output
        self.createHabitDB = createHabitDB
        self.habit = habit
    }
}

// MARK: - Public
public extension CreateHabitInteractor {
    func setHabitTitle(_ habitTitle: String) {
        habit.habitTitle = habitTitle
    }

    func setCreationDate(_ creationDate: Date) {
        habit.creationDate = creationDate
    }

    func setTimePeriod(_ timePeriod: HabitTimePeriod) {
        habit.timePeriod = timePeriod
    }

    func setSchedule(_ schedule: [HabitScheduleDay]) {
        habit.schedule = schedule
    }

    func setHabitDataType(_ habitDataType: HabitDataType) {
        habit.habitDataType = habitDataType
    }

    func canAddHabit() -> Bool {
        return !habit.habitTitle.isEmpty
            && !habit.schedule.isEmpty
    }

    func addHabit() {
        guard canAddHabit() else {
            output.presentHabitAddingFailure()
            return
        }

        createHabitDB.addHabit(habit)
        output.presentHabitAddedSuccessfuly()
    }

    func getHabit() -> Habit {
        return habit
    }
}
