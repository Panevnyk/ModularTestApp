//
//  HabitListInteractorTests.swift
//  DomainTests
//
//  Created by Vladyslav Panevnyk on 20.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import Domain

final class HabitListInteractorTests: XCTestCase {
    // MARK: - Mocks
    private let output = HabitListInteractorOutputMock()
    private let habitListDBMock = HabitListDBBoundaryMock()

    // MARK: - Tests load habits
    func test_loadHabits() {
        let sut = makeSUT()
        habitListDBMock.mockedHabits = makeHabits(titles: ["T1", "T2", "T3"])

        sut.loadHabits()

        XCTAssertEqual(output.presentedHabits?.count, 3)
        XCTAssertEqual(output.presentedHabits?[0].habitTitle, "T1")
        XCTAssertEqual(output.presentedHabits?[1].habitTitle, "T2")
        XCTAssertEqual(output.presentedHabits?[2].habitTitle, "T3")
    }

    // MARK: - Tests remove habit
    func test_removeHabit_withCorrectDataAndIndex() {
        let sut = makeSUT()
        habitListDBMock.mockedHabits = makeHabits(titles: ["T1", "T2", "T3"])
        habitListDBMock.isHabitRemovingFromDBSuccessfullyFinished = true

        sut.loadHabits()
        sut.removeHabit(by: 0)

        XCTAssertEqual(output.habitRemoveSuccessullyIndex, 0)
    }

    func test_removeHabit_withOutOfBoundsIndex() {
        let sut = makeSUT()
        habitListDBMock.mockedHabits = makeHabits(titles: ["T1", "T2", "T3"])
        habitListDBMock.isHabitRemovingFromDBSuccessfullyFinished = true

        sut.loadHabits()
        sut.removeHabit(by: 3)

        XCTAssertEqual(output.habitRemoveFailureIndex, 3)
    }

    func test_removeHabit_withFailOnDataBase() {
        let sut = makeSUT()
        habitListDBMock.mockedHabits = makeHabits(titles: ["T1", "T2", "T3"])
        habitListDBMock.isHabitRemovingFromDBSuccessfullyFinished = false

        sut.loadHabits()
        sut.removeHabit(by: 2)

        XCTAssertEqual(output.habitRemoveFailureIndex, 2)
    }

    // MARK: - Helpers
    func makeSUT() -> HabitListInteractor {
        let sut = HabitListInteractor(output: output, habitListDB: habitListDBMock)
        return sut
    }

    func makeHabits(titles: [String]) -> [Habit] {
        return titles.map { makeHabit(title: $0) }
    }

    func makeHabit(title: String) -> Habit {
        return Habit(habitTitle: title,
                     creationDate: makeDate("12/30/2018"),
                     timePeriod: .day,
                     schedule: HabitScheduleDay.allCases,
                     habitDataType: .boolean,
                     habitDatas: [])
    }
}

// MARK: - Mock
private extension HabitListInteractorTests {
    final class HabitListInteractorOutputMock: HabitListInteractorOutput {
        var presentedHabits: [Habit]?
        var habitRemoveSuccessullyIndex: Int?
        var habitRemoveFailureIndex: Int?

        func present(habits: [Habit]) {
            presentedHabits = habits
        }

        func presentHabitDidRemoveSuccessfully(by index: Int) {
            habitRemoveSuccessullyIndex = index
        }

        func presentHabitDidRemoveFailure(by index: Int) {
            habitRemoveFailureIndex = index
        }
    }

    final class HabitListDBBoundaryMock: HabitListDBBoundary {
        var mockedHabits: [Habit] = []
        var isHabitRemovingFromDBSuccessfullyFinished = false

        func getAllHabits() -> [Habit] {
            return mockedHabits
        }

        func remove(habit: Habit) -> Bool {
            return isHabitRemovingFromDBSuccessfullyFinished
        }
    }
}
