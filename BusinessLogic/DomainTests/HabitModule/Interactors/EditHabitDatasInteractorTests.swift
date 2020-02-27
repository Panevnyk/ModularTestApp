//
//  QuestionPollInteractorTests.swift
//  Domain
//
//  Created by Vladyslav Panevnyk on 24.01.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import Domain

final class EditHabitDatasInteractorTests: XCTestCase {
    // MARK: - Mocks
    private let output = EditHabitDatasInteractorOutputMock()
    private let editHabitsDataDBMock = EditHabitDatasDBBoundaryMock()

    // MARK: - Tests add HabitData output and adding into DB
    func test_addHabitData_incorrectValue_dataWasNotAdded() {
        let habit = Habit(habitTitle: "", timePeriod: .day, habitDataType: .boolean, habitDatas: [])
        let sut = makeSUT(habit: habit)

        let habitData = HabitData(id: UUID(), value: 3, date: Date())
        sut.addHabitData(habitData)

        XCTAssertEqual(output.isHabitAddingFailure, true)
        XCTAssertNil(editHabitsDataDBMock.insertedHabitData)
    }

    func test_addHabitData_correctValue_dataWasAdded() {
        let habit = Habit(habitTitle: "", timePeriod: .day, habitDataType: .range, habitDatas: [])
        let sut = makeSUT(habit: habit)

        let habitData = HabitData(id: UUID(), value: 3, date: Date())
        sut.addHabitData(habitData)

        XCTAssertEqual(output.isHabitsWasAddedSuccessfuly, true)
        XCTAssertEqual(editHabitsDataDBMock.insertedHabitData?.id, habitData.id)
        XCTAssertEqual(editHabitsDataDBMock.insertedHabitData?.value as? Int, 3)
        XCTAssertEqual(editHabitsDataDBMock.insertedHabitData?.date, habitData.date)
    }

    // MARK: - Tests is Habit contain HabitData
    func test_isHabitContainHabitData_correct() {
        let habitData = HabitData(id: UUID(), value: 3, date: Date())
        let habit = Habit(habitTitle: "", timePeriod: .day, habitDataType: .range, habitDatas: [habitData])
        let sut = makeSUT(habit: habit)

        XCTAssertEqual(sut.isHabitContainHabitData(by: habitData.id), true)
    }

    func test_isHabitContainHabitData_incorrect() {
        let habitData = HabitData(id: UUID(), value: 3, date: Date())
        let habit = Habit(habitTitle: "", timePeriod: .day, habitDataType: .range, habitDatas: [habitData])
        let sut = makeSUT(habit: habit)

        XCTAssertEqual(sut.isHabitContainHabitData(by: habitData.id), true)
    }

    // MARK: - Tests edit HabitData
    func test_updateHabitData_correctValue_valueWasChanged() {
        let habitData1 = HabitData(id: UUID(), value: 1, date: Date())
        let habitData2 = HabitData(id: UUID(), value: 2, date: Date())
        let habitData3 = HabitData(id: UUID(), value: 3, date: Date())
        let habit = Habit(habitTitle: "", timePeriod: .day, habitDataType: .range, habitDatas: [habitData1, habitData2, habitData3])
        let sut = makeSUT(habit: habit)

        let updateHabitData = HabitData(id: habitData2.id, value: 222, date: habitData2.date)
        sut.updateHabitData(updateHabitData)

        let habitDatas = sut.getHabit().habitDatas
        XCTAssertEqual(habitDatas.count, 3)
        XCTAssertEqual(habitDatas[0].value as? Int, 1)
        XCTAssertEqual(habitDatas[1].value as? Int, 222)
        XCTAssertEqual(habitDatas[2].value as? Int, 3)

        XCTAssertEqual(output.isHabitsWasUpdatedSuccessfuly, true)
        XCTAssertEqual(editHabitsDataDBMock.updatedHabitData?.id, updateHabitData.id)
        XCTAssertEqual(editHabitsDataDBMock.updatedHabitData?.value as? Int, 222)
        XCTAssertEqual(editHabitsDataDBMock.updatedHabitData?.date, updateHabitData.date)
    }

    func test_updateHabitData_incorrectValue_valueWasNotChanged() {
        let habitData1 = HabitData(id: UUID(), value: 1, date: Date())
        let habitData2 = HabitData(id: UUID(), value: 2, date: Date())
        let habitData3 = HabitData(id: UUID(), value: 3, date: Date())
        let habit = Habit(habitTitle: "", timePeriod: .day, habitDataType: .range, habitDatas: [habitData1, habitData2, habitData3])
        let sut = makeSUT(habit: habit)

        let updateHabitData = HabitData(id: habitData2.id, value: false, date: habitData2.date)
        sut.updateHabitData(updateHabitData)

        let habitDatas = sut.getHabit().habitDatas
        XCTAssertEqual(habitDatas.count, 3)
        XCTAssertEqual(habitDatas[0].value as? Int, 1)
        XCTAssertEqual(habitDatas[1].value as? Int, 2)
        XCTAssertEqual(habitDatas[2].value as? Int, 3)

        XCTAssertEqual(output.isHabitUpdatingFailure, true)
        XCTAssertNil(editHabitsDataDBMock.updatedHabitData)
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
        var isHabitsWasUpdatedSuccessfuly = false
        var isHabitUpdatingFailure = false

        func habitsWasAddedSuccessfuly(by index: Int) {
            isHabitsWasAddedSuccessfuly = true
        }

        func habitAddingFailure() {
            isHabitAddingFailure = true
        }

        func habitsWasUpdatedSuccessfuly(by index: Int) {
            isHabitsWasUpdatedSuccessfuly = true
        }

        func habitUpdatingFailure() {
            isHabitUpdatingFailure = true
        }
    }

    final class EditHabitDatasDBBoundaryMock: EditHabitDatasDBBoundary {
        var insertedHabitData: HabitData?
        var updatedHabitData: HabitData?

        func insert(_ habitData: HabitData, to habit: Habit, at index: Int) {
            self.insertedHabitData = habitData
        }

        func update(_ habitData: HabitData, in habit: Habit, at index: Int) {
            self.updatedHabitData = habitData
        }
    }
}
