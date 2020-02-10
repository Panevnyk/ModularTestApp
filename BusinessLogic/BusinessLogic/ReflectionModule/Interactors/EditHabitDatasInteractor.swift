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
    func isHabitContainHabitData(by id: UUID) -> Bool
    func updateHabitData(_ habitData: HabitData)
    func getHabit() -> Habit
}

public protocol EditHabitDatasInteractorOutput {
    func habitsWasAddedSuccessfuly(by index: Int)
    func habitAddingFailure()

    func habitsWasUpdatedSuccessfuly(by index: Int)
    func habitUpdatingFailure()
}

public protocol EditHabitDatasDBBoundary {
    func insert(_ habitData: HabitData, to habit: Habit, at index: Int)
    func update(_ habitData: HabitData, in habit: Habit, at index: Int)
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
        editHabitsDataDB.insert(habitData, to: habit, at: 0)
        output.habitsWasAddedSuccessfuly(by: 0)
    }

    func isHabitContainHabitData(by id: UUID) -> Bool {
        return habit.habitDatas.contains(where: {  $0.id == id })
    }

    func updateHabitData(_ habitData: HabitData) {
        guard let index = habit.habitDatas.firstIndex(of: habitData), habit.canAddedHabitData(habitData) else {
            output.habitUpdatingFailure()
            return
        }

        habit.habitDatas.remove(at: index)
        habit.habitDatas.insert(habitData, at: index)
        editHabitsDataDB.update(habitData, in: habit, at: index)
        output.habitsWasUpdatedSuccessfuly(by: index)
    }

    func getHabit() -> Habit {
        return habit
    }
}
