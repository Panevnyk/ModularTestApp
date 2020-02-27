//
//  HabitListInteractor.swift
//  Domain
//
//  Created by Vladyslav Panevnyk on 20.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

public protocol HabitListInteractorInput: class {
    func loadHabits()
}

public protocol HabitListInteractorOutput {
    func present(habits: [Habit])
}

public protocol HabitListDBBoundary {
    func getAllHabits() -> [Habit]
}

public final class HabitListInteractor: HabitListInteractorInput {
    // MARK: - Properties
    private let output: HabitListInteractorOutput
    private let habitListDB: HabitListDBBoundary

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
        let habits = habitListDB.getAllHabits()
        output.present(habits: habits)
    }
}
