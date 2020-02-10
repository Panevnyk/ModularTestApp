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

    // MARK: - Tests add HabitData output and adding into DB
    func test_addHabitData_incorrectValue_dataWasNotAdded() {
        let habit = Habit(habitTitle: "", habitDataType: .boolean, habitDatas: [])
        let sut = makeSUT(habit: habit)

        let habitData = HabitData(id: UUID(), value: 3, date: Date())
        sut.addHabitData(habitData)

        XCTAssertEqual(output.isHabitAddingFailure, true)
        XCTAssertNil(editHabitsDataDBMock.habitData)
    }

    func test_addHabitData_correctValue_dataWasAdded() {
        let habit = Habit(habitTitle: "", habitDataType: .counting, habitDatas: [])
        let sut = makeSUT(habit: habit)

        let habitData = HabitData(id: UUID(), value: 3, date: Date())
        sut.addHabitData(habitData)

        XCTAssertEqual(output.isHabitsWasAddedSuccessfuly, true)
        XCTAssertEqual(editHabitsDataDBMock.habitData?.id, habitData.id)
        XCTAssertEqual(editHabitsDataDBMock.habitData?.value as? Int, 3)
        XCTAssertEqual(editHabitsDataDBMock.habitData?.date, habitData.date)
    }

    // MARK: - Tests is Habit contain HabitData
    func test_isHabitContainHabitData_correct() {
        let habitData = HabitData(id: UUID(), value: 3, date: Date())
        let habit = Habit(habitTitle: "", habitDataType: .counting, habitDatas: [habitData])
        let sut = makeSUT(habit: habit)

        XCTAssertEqual(sut.isHabitContainHabitData(by: habitData.id), true)
    }

    func test_isHabitContainHabitData_incorrect() {
        let habitData = HabitData(id: UUID(), value: 3, date: Date())
        let habit = Habit(habitTitle: "", habitDataType: .counting, habitDatas: [habitData])
        let sut = makeSUT(habit: habit)

        XCTAssertEqual(sut.isHabitContainHabitData(by: habitData.id), true)
    }

    // MARK: - Tests edit HabitData
    func test_editHabitData_correctValue_valueWasChanged() {
        let habitData1 = HabitData(id: UUID(), value: 1, date: Date())
        let habitData2 = HabitData(id: UUID(), value: 2, date: Date())
        let habitData3 = HabitData(id: UUID(), value: 3, date: Date())
        let habit = Habit(habitTitle: "", habitDataType: .counting, habitDatas: [habitData1, habitData2, habitData3])
        let sut = makeSUT(habit: habit)

        let editedHabitData = HabitData(id: habitData2.id, value: 222, date: habitData2.date)
        sut.editHabitData(editedHabitData)

        let habitDatas = sut.getHabit().habitDatas
        XCTAssertEqual(habitDatas.count, 3)
        XCTAssertEqual(habitDatas[0].value as? Int, 1)
        XCTAssertEqual(habitDatas[1].value as? Int, 222)
        XCTAssertEqual(habitDatas[2].value as? Int, 3)
    }

    func test_editHabitData_incorrectValue_valueWasNotChanged() {
        let habitData1 = HabitData(id: UUID(), value: 1, date: Date())
        let habitData2 = HabitData(id: UUID(), value: 2, date: Date())
        let habitData3 = HabitData(id: UUID(), value: 3, date: Date())
        let habit = Habit(habitTitle: "", habitDataType: .counting, habitDatas: [habitData1, habitData2, habitData3])
        let sut = makeSUT(habit: habit)

        let editedHabitData = HabitData(id: habitData2.id, value: false, date: habitData2.date)
        sut.editHabitData(editedHabitData)

        let habitDatas = sut.getHabit().habitDatas
        XCTAssertEqual(habitDatas.count, 3)
        XCTAssertEqual(habitDatas[0].value as? Int, 1)
        XCTAssertEqual(habitDatas[1].value as? Int, 2)
        XCTAssertEqual(habitDatas[2].value as? Int, 3)
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
