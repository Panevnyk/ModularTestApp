//
//  CreateHabitInteractorTests.swift
//  Domain
//
//  Created by Vladyslav Panevnyk on 11.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import Domain

final class CreateHabitInteractorTests: XCTestCase {
    // MARK: - Mocks
    private let output = CreateHabitInteractorOutputMock()
    private let createHabitDBMock = CreateHabitDBBoundaryMock()

    // MARK: - Tests initial datas
    func test_initialHabitData() {
        let habit = makeSUT().getHabit()
        XCTAssertEqual(habit.habitTitle, "")
        XCTAssertEqual(habit.timePeriod, .day)
        XCTAssertEqual(habit.schedule, HabitScheduleDay.allCases)
        XCTAssertEqual(habit.habitDataType, .boolean)
        XCTAssertEqual(habit.habitDatas, [])
    }

    // MARK: - Tests canAddHabit
    func test_canAddHabit_emptyData_falseResult() {
        XCTAssertEqual(makeSUT().canAddHabit(), false)
    }

    func test_canAddHabit_withHabitTitle_trueResult() {
        let sut = makeSUT()
        sut.setHabitTitle("Health")
        XCTAssertEqual(sut.canAddHabit(), true)
    }

    func test_canAddHabit_withEmptySchedule_falseResult() {
        let sut = makeSUT()
        sut.setSchedule([])
        XCTAssertEqual(sut.canAddHabit(), false)
    }

    // MARK: - Tests add Habit
    func test_addHabit_success() {
        let sut = makeSUT()
        sut.setHabitTitle("Health")
        sut.setSchedule([.monday, .wednesday, .friday])
        sut.setCreationDate(makeDate("01/01/2012"))
        sut.setHabitDataType(.description)

        sut.addHabit()

        XCTAssertEqual(output.isHabitDidCreateSuccessfuly, true)
        let addedHabit = createHabitDBMock.addedHabit
        XCTAssertNotNil(addedHabit)
        XCTAssertEqual(addedHabit?.habitTitle, "Health")
        XCTAssertEqual(addedHabit?.schedule, [.monday, .wednesday, .friday])
        XCTAssertEqual(addedHabit?.creationDate, makeDate("01/01/2012"))
        XCTAssertEqual(addedHabit?.habitDataType, .description)
    }

    func test_addHabit_failure() {
        let sut = makeSUT()
        sut.setHabitTitle("")
        sut.setSchedule([])
        sut.setCreationDate(makeDate("01/01/2012"))
        sut.setHabitDataType(.description)

        sut.addHabit()

        XCTAssertEqual(output.isHabitCreationFailure, true)
        XCTAssertNil(createHabitDBMock.addedHabit)
    }

    // MARK: - Helpers
    func makeSUT() -> CreateHabitInteractor {
        let sut = CreateHabitInteractor(output: output, createHabitDB: createHabitDBMock)
        return sut
    }
}

// MARK: - Mock
private extension CreateHabitInteractorTests {
    final class CreateHabitInteractorOutputMock: CreateHabitInteractorOutput {
        var isHabitDidCreateSuccessfuly = false
        var isHabitCreationFailure = false

        func present(habit: Habit) {}

        func habitAddedSuccessfuly() {
            isHabitDidCreateSuccessfuly = true
        }

        func habitAddingFailure() {
            isHabitCreationFailure = true
        }
    }

    final class CreateHabitDBBoundaryMock: CreateHabitDBBoundary {
        var addedHabit: Habit?

        func addHabit(_ habit: Habit) {
            addedHabit = habit
        }
    }
}
