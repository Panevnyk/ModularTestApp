//
//  HabitListInteractor.swift
//  Domain
//
//  Created by Vladyslav Panevnyk on 20.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

public protocol HabitListInteractorInput: class {
    func loadHabits()
    func removeHabit(by index: Int)
}

public protocol HabitListInteractorOutput {
    func present(habits: [Habit])
    func presentHabitDidRemoveSuccessfully(by index: Int)
    func presentHabitDidRemoveFailure(by index: Int)
}

public protocol HabitListDBBoundary {
    func getAllHabits() -> [Habit]
    func remove(habit: Habit) -> Bool
}

public final class HabitListInteractor: HabitListInteractorInput {
    // MARK: - Properties
    private let output: HabitListInteractorOutput
    private let habitListDB: HabitListDBBoundary
    private var habits: [Habit] = []

    // MARK: - Init
    public init(output: HabitListInteractorOutput,
                habitListDB: HabitListDBBoundary) {
        self.output = output
        self.habitListDB = habitListDB
    }
}

// MARK: - Public
public extension HabitListInteractor {
    func loadHabits() {
        habits = habitListDB.getAllHabits()
        output.present(habits: habits)
    }

    func removeHabit(by index: Int) {
        guard let habit = getHabit(by: index) else {
            output.presentHabitDidRemoveFailure(by: index)
            return
        }

        if habitListDB.remove(habit: habit) {
            habits.remove(at: index)
            output.presentHabitDidRemoveSuccessfully(by: index)
        } else {
            output.presentHabitDidRemoveFailure(by: index)
        }
    }
}

// MARK: - Helpers
private extension HabitListInteractor {
    func getHabit(by index: Int) -> Habit? {
        guard habits.count > index else { return nil }
        return habits[index]
    }
}
