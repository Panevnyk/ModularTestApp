//
//  QuestionPollInteractorTests.swift
//  BusinessLogic
//
//  Created by Vladyslav Panevnyk on 24.01.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import BusinessLogic

final class EditHabitDatasInteractorTests: XCTestCase {
    // MARK: - Mocks
    private let output = EditHabitDatasInteractorOutputMock()
    private let editHabitsDataDBMock = EditHabitDatasDBBoundaryMock()

    // MARK: - Tests add HabitData output
    func test_addHabitDataOutput_incorrectValue_dataWasNotAdded() {
        let habit = Habit(habitTitle: "", habitDataType: .boolean, habitDatas: [])
        let sut = makeSUT(habit: habit)

        let habitData = HabitData(id: UUID(), value: 3, date: Date())
        sut.addHabitData(habitData)

        XCTAssertEqual(output.isHabitAddingFailure, true)
    }

    func test_addHabitDataOutput_correctValue_dataWasAdded() {
        let habit = Habit(habitTitle: "", habitDataType: .counting, habitDatas: [])
        let sut = makeSUT(habit: habit)

        let habitData = HabitData(id: UUID(), value: 3, date: Date())
        sut.addHabitData(habitData)

        XCTAssertEqual(output.isHabitsWasAddedSuccessfuly, true)
    }

    // MARK: - Tests add HabitData into DB
    func test_addHabitDataDB_incorrectValue_dataWasNotAdded() {
        let habit = Habit(habitTitle: "", habitDataType: .boolean, habitDatas: [])
        let sut = makeSUT(habit: habit)

        let habitData = HabitData(id: UUID(), value: 3, date: Date())
        sut.addHabitData(habitData)

        XCTAssertNil(editHabitsDataDBMock.habitData)
    }

    func test_addHabitDataDB_correctValue_dataWasAdded() {
        let habit = Habit(habitTitle: "", habitDataType: .counting, habitDatas: [])
        let sut = makeSUT(habit: habit)

        let habitData = HabitData(id: UUID(), value: 3, date: Date())
        sut.addHabitData(habitData)

        XCTAssertEqual(editHabitsDataDBMock.habitData?.id, habitData.id)
        XCTAssertEqual(editHabitsDataDBMock.habitData?.value as? Int, 3)
        XCTAssertEqual(editHabitsDataDBMock.habitData?.date, habitData.date)
    }

    // MARK: - Helpers
    func makeSUT(habit: Habit) -> EditHabitDatasInteractor {
        let sut = EditHabitDatasInteractor(output: output,
                                           editHabitsDataDB: editHabitsDataDBMock,
                                           habit: habit)
        return sut
    }
}

// MARK: - Mocks
private extension EditHabitDatasInteractorTests {
    final class EditHabitDatasInteractorOutputMock: EditHabitDatasInteractorOutput {
        var isHabitsWasAddedSuccessfuly = false
        var isHabitAddingFailure = false

        func habitsWasAddedSuccessfuly(by index: Int) {
            isHabitsWasAddedSuccessfuly = true
        }

        func habitAddingFailure() {
            isHabitAddingFailure = true
        }
    }

    final class EditHabitDatasDBBoundaryMock: EditHabitDatasDBBoundary {
        var habitData: HabitData?

        func insert(_ habitData: HabitData, at index: Int) {
            self.habitData = habitData
        }
    }
}
