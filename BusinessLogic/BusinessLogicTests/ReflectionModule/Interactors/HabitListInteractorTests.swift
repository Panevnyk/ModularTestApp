//
//  HabitListInteractorTests.swift
//  BusinessLogicTests
//
//  Created by Vladyslav Panevnyk on 20.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import BusinessLogic

final class HabitListInteractorTests: XCTestCase {
    // MARK: - Mocks
    private let output = HabitListInteractorOutputMock()
    private let habitListDBMock = HabitListDBBoundaryMock()

    // MARK: - Tests
    func test_loadHabits() {
        let habits = makeHabits(titles: ["T1", "T2", "T3"])
        let sut = makeSUT()
        habitListDBMock.mockedHabits = habits

        sut.loadHabits()

        XCTAssertEqual(output.presentedHabits?.count, 3)
        XCTAssertEqual(output.presentedHabits?[0].habitTitle, "T1")
        XCTAssertEqual(output.presentedHabits?[1].habitTitle, "T2")
        XCTAssertEqual(output.presentedHabits?[2].habitTitle, "T3")
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

        func present(habits: [Habit]) {
            presentedHabits = habits
        }
    }

    final class HabitListDBBoundaryMock: HabitListDBBoundary {
        var mockedHabits: [Habit] = []

        func getAllHabits() -> [Habit] {
            return mockedHabits
        }
    }
}
