//
//  CreateQuestionPoolInteractorTests.swift
//  Domain
//
//  Created by Vladyslav Panevnyk on 24.01.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import Domain

final class EditHabitsAreaInteractorTests: XCTestCase {
    // MARK: - Mocks
    private let output = EditHabitsAreaInteractorOutputMock()
    private let editHabitsAreaDBMock = EditHabitsAreaDBBoundaryMock()

    // MARK: - Tests save HabitsArea output
    func test_saveHabitsAreaOutput_withNoQuestions_poolCreationFailure() {
        makeSUT().saveHabitsArea()
        XCTAssertTrue(output.isHabitsAreaCreationFailure)
    }

    func test_createQuestionPoolOutput_withOneQuestion_poolCreatedSuccessfuly() {
        let sut = makeSUT()

        sut.addHabit(Habit(habitTitle: "", timePeriod: .day, habitDataType: .boolean, habitDatas: []))
        sut.saveHabitsArea()

        XCTAssertTrue(output.ishabitsAreaDidCreateSuccessfuly)
    }

    // MARK: - Tests save HabitsArea save into DB
    func test_saveHabitsAreaDB_withNoQuestions_poolCreationFailure() {
        makeSUT().saveHabitsArea()
        XCTAssertNil(editHabitsAreaDBMock.habitsArea)
    }

    func test_createQuestionPoolDB_withTwoQuestions_poolCreatedSuccessfuly() {
        let sut = makeSUT()

        sut.addHabit(Habit(habitTitle: "Test1", timePeriod: .day, habitDataType: .boolean, habitDatas: []))
        sut.addHabit(Habit(habitTitle: "Test2", timePeriod: .day, habitDataType: .range, habitDatas: []))
        sut.saveHabitsArea()

        let habits = editHabitsAreaDBMock.habitsArea?.habits
        let firstHabit = habits?.first
        let secondHabit = habits?.last

        XCTAssertEqual(habits?.count, 2)

        XCTAssertNotNil(firstHabit)
        XCTAssertEqual(firstHabit!.habitTitle, "Test1")
        XCTAssertEqual(firstHabit!.habitDataType, .boolean)

        XCTAssertNotNil(secondHabit)
        XCTAssertEqual(secondHabit!.habitTitle, "Test2")
        XCTAssertEqual(secondHabit!.habitDataType, .range)
    }

    // MARK: - Tests can save HabitsArea
    func test_canCreateQuestionPool_withTwoQuestions_falseResult() {
        let canSaveHabitsArea = makeSUT().canSaveHabitsArea()
        XCTAssertFalse(canSaveHabitsArea)
    }

    func test_canCreateQuestionPool_withNoQuestions_falseResult() {
        let sut = makeSUT()

        sut.addHabit(Habit(habitTitle: "Test1", timePeriod: .day, habitDataType: .boolean, habitDatas: []))
        sut.addHabit(Habit(habitTitle: "Test2", timePeriod: .day, habitDataType: .range, habitDatas: []))
        let canSaveHabitsArea = sut.canSaveHabitsArea()

        XCTAssertTrue(canSaveHabitsArea)
    }

    // MARK: - Helpers
    func makeSUT() -> EditHabitsAreaInteractor {
        let sut = EditHabitsAreaInteractor(output: output, editHabitsAreaDB: editHabitsAreaDBMock)
        return sut
    }
}

// MARK: - Mocks
private extension EditHabitsAreaInteractorTests {
    class EditHabitsAreaInteractorOutputMock: EditHabitsAreaInteractorOutput {
        var ishabitsAreaDidCreateSuccessfuly = false
        var isHabitsAreaCreationFailure = false

        func habitsAreaSavedSuccessfuly() {
            ishabitsAreaDidCreateSuccessfuly = true
        }
        
        func habitsAreaSavingFailure() {
            isHabitsAreaCreationFailure = true
        }
    }

    class EditHabitsAreaDBBoundaryMock: EditHabitsAreaDBBoundary {
        var habitsArea: HabitsArea?

        func saveHabitsArea(_ habitsArea: HabitsArea) {
            self.habitsArea = habitsArea
        }
    }
}
