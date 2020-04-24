//
//  HabitListInteractorTests.swift
//  HabbityDomainTests
//
//  Created by Vladyslav Panevnyk on 20.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import HabbityDomain

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
    func test_removeHabit_checkOutput() {
        let sut = makeSUT()
        habitListDBMock.mockedHabits = makeHabits(titles: ["T1", "T2", "T3"])
        habitListDBMock.isHabitRemovingFromDBSuccessfullyFinished = true

        sut.loadHabits()
        sut.removeHabit(by: 0)

        XCTAssertEqual(output.habitRemoveSuccessullyIndex, [0])
    }

    func test_removeHabit_checkDB() {
        let sut = makeSUT()
        habitListDBMock.mockedHabits = makeHabits(titles: ["T1", "T2", "T3"])
        habitListDBMock.isHabitRemovingFromDBSuccessfullyFinished = true

        sut.loadHabits()
        sut.removeHabit(by: 0)

        XCTAssertEqual(habitListDBMock.removedHabits.map { $0.habitTitle }, ["T1"])
    }

    func test_removeMultipleHabits_checkOutput() {
        let sut = makeSUT()
        habitListDBMock.mockedHabits = makeHabits(titles: ["T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8"])
        habitListDBMock.isHabitRemovingFromDBSuccessfullyFinished = true

        sut.loadHabits()
        sut.removeHabit(by: 1)
        sut.removeHabit(by: 3)
        sut.removeHabit(by: 5)

        XCTAssertEqual(output.habitRemoveSuccessullyIndex, [1, 3, 5])
    }

    func test_removeMultipleHabits_checkDB() {
        let sut = makeSUT()
        habitListDBMock.mockedHabits = makeHabits(titles: ["T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8"])
        habitListDBMock.isHabitRemovingFromDBSuccessfullyFinished = true

        sut.loadHabits()
        sut.removeHabit(by: 1)
        sut.removeHabit(by: 3)
        sut.removeHabit(by: 5)

        XCTAssertEqual(habitListDBMock.removedHabits.map { $0.habitTitle }, ["T2", "T5", "T8"])
    }

    func test_removeHabit_withOutOfBoundsIndex() {
        let sut = makeSUT()
        habitListDBMock.mockedHabits = makeHabits(titles: ["T1", "T2", "T3"])
        habitListDBMock.isHabitRemovingFromDBSuccessfullyFinished = true

        sut.loadHabits()
        sut.removeHabit(by: 3)

        XCTAssertEqual(output.habitRemoveFailureIndex, 3)
    }

    func test_removeMultipleHabits_checkDB_withLastRemoveOutOfBounds() {
        let sut = makeSUT()
        habitListDBMock.mockedHabits = makeHabits(titles: ["T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8"])
        habitListDBMock.isHabitRemovingFromDBSuccessfullyFinished = true

        sut.loadHabits()
        sut.removeHabit(by: 1)
        sut.removeHabit(by: 3)
        sut.removeHabit(by: 6)

        XCTAssertEqual(habitListDBMock.removedHabits.map { $0.habitTitle }, ["T2", "T5"])
    }

    func test_removeMultipleHabits_checkOutput_withLastRemoveOutOfBounds() {
        let sut = makeSUT()
        habitListDBMock.mockedHabits = makeHabits(titles: ["T1", "T2", "T3", "T4", "T5", "T6", "T7", "T8"])
        habitListDBMock.isHabitRemovingFromDBSuccessfullyFinished = true

        sut.loadHabits()
        sut.removeHabit(by: 1)
        sut.removeHabit(by: 3)
        sut.removeHabit(by: 6)

        XCTAssertEqual(output.habitRemoveSuccessullyIndex, [1, 3])
        XCTAssertEqual(output.habitRemoveFailureIndex, 6)
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
        return Habit(id: UUID(),
                     habitTitle: title,
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
        var habitRemoveSuccessullyIndex: [Int] = []
        var habitRemoveFailureIndex: Int?

        func present(habits: [Habit]) {
            presentedHabits = habits
        }

        func presentHabitDidRemoveSuccessfully(by index: Int) {
            habitRemoveSuccessullyIndex.append(index)
        }

        func presentHabitDidRemoveFailure(by index: Int) {
            habitRemoveFailureIndex = index
        }
    }

    final class HabitListDBBoundaryMock: HabitListDBBoundary {
        var mockedHabits: [Habit] = []
        var isHabitRemovingFromDBSuccessfullyFinished = false
        var removedHabits: [Habit] = []

        func getAllHabits() -> [Habit] {
            return mockedHabits
        }

        func getAllHabits(completion: ((_ : [Habit]) -> Void)?) {
            completion?([])
        }

        func remove(habit: Habit) -> Bool {
            removedHabits.append(habit)
            return isHabitRemovingFromDBSuccessfullyFinished
        }
    }
}
