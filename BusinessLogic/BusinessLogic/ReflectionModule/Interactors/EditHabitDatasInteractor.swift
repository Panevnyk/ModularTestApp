//
//  QuestionPollInteractor.swift
//  BusinessLogic
//
//  Created by Vladyslav Panevnyk on 28.01.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import Foundation

public protocol EditHabitDatasInteractorInput {
    func addHabitData(_ habitData: HabitData)
    func getHabit() -> Habit
}

public protocol EditHabitDatasInteractorOutput {
    func habitsWasAddedSuccessfuly(by index: Int)
    func habitAddingFailure()
}

public protocol EditHabitDatasDBBoundary {
    func insert(_ habitData: HabitData, at index: Int)
}

public final class EditHabitDatasInteractor: EditHabitDatasInteractorInput {
    // MARK: - Properties
    private let output: EditHabitDatasInteractorOutput
    private let editHabitsDataDB: EditHabitDatasDBBoundary
    private var habit: Habit

    // MARK: - Inits
    public init(output: EditHabitDatasInteractorOutput,
                editHabitsDataDB: EditHabitDatasDBBoundary,
                habit: Habit) {
        self.output = output
        self.editHabitsDataDB = editHabitsDataDB
        self.habit = habit
    }
}

// MARK: - Public
public extension EditHabitDatasInteractor {
    func addHabitData(_ habitData: HabitData) {
        guard habit.canAddedHabitData(habitData) else {
            output.habitAddingFailure()
            return
        }

        habit.habitDatas.insert(habitData, at: 0)
        editHabitsDataDB.insert(habitData, at: 0)
        output.habitsWasAddedSuccessfuly(by: 0)
    }

    func getHabit() -> Habit {
        return habit
    }
}
