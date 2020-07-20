//
//  CreateQuestionPoolInteractor.swift
//  HabbityDomain
//
//  Created by Vladyslav Panevnyk on 24.01.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

public protocol EditHabitsAreaInteractorInput: class {
    func addHabit(_ habit: Habit)
    func saveHabitsArea()
    func canSaveHabitsArea() -> Bool
}

public protocol EditHabitsAreaInteractorOutput {
    func habitsAreaSavedSuccessfuly()
    func habitsAreaSavingFailure()
}

public protocol EditHabitsAreaDBBoundary {
    func saveHabitsArea(_ habitsArea: HabitsArea)
}

public final class EditHabitsAreaInteractor: EditHabitsAreaInteractorInput {
    // MARK: - Properties
    private let output: EditHabitsAreaInteractorOutput
    private let editHabitsAreaDB: EditHabitsAreaDBBoundary
    private var habitArea: HabitsArea

    // MARK: - Inits
    public init(output: EditHabitsAreaInteractorOutput, editHabitsAreaDB: EditHabitsAreaDBBoundary) {
        self.output = output
        self.editHabitsAreaDB = editHabitsAreaDB
        self.habitArea = HabitsArea(habitAreaTitle: "", habits: [])
    }
}

// MARK: - Public
public extension EditHabitsAreaInteractor {
    func addHabit(_ habit: Habit) {
        habitArea.habits.append(habit)
    }

    func saveHabitsArea() {
        guard canSaveHabitsArea() else {
            output.habitsAreaSavingFailure()
            return
        }

        editHabitsAreaDB.saveHabitsArea(habitArea)
        output.habitsAreaSavedSuccessfuly()
    }

    func canSaveHabitsArea() -> Bool {
        return !habitArea.habits.isEmpty
    }
}
