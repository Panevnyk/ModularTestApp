//
//  PlacePresenterTests.swift
//  iOSUITests
//
//  Created by Vladyslav Panevnyk on 18.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import Domain
@testable import iOSUI

final class HabitListPresenterTests: XCTestCase {
    // MARK: - Mocks
    private let output = HabitListPresenterOutputMock()
    
    // MARK: - Tests
    func test_presentHabits() {
        let sut = makeSUT()
        let habit1 = makeHabit(title: "Test1")
        let habit2 = makeHabit(title: "Test2")
        
        sut.present(habits: [habit1, habit2])

        let viewModels = output.presentedHabitViewModels
        XCTAssertEqual(viewModels?.count, 2)
        XCTAssertEqual(viewModels?.first?.id, 0)
        XCTAssertEqual(viewModels?.last?.id, 1)
        XCTAssertEqual(viewModels?.first?.title, "Test1")
        XCTAssertEqual(viewModels?.last?.title, "Test2")
    }

    func test_presentHabitDidRemoveSuccessfully() {
        makeSUT().presentHabitDidRemoveSuccessfully(by: 1)
        XCTAssertEqual(output.displayedHabitDidRemoveSuccessfullyIndex, 1)
    }

    func test_presentHabitDidRemoveFailure() {
        makeSUT().presentHabitDidRemoveFailure(by: 1)
        XCTAssertEqual(output.displayedHabitDidRemoveFailureIndex, 1)
    }
    
    // MARK: - Helper
    func makeSUT() -> HabitListPresenter {
        let sut = HabitListPresenter()
        sut.view = output
        return sut
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

// MARK: - Mocks
private extension HabitListPresenterTests {
    class HabitListPresenterOutputMock: HabitListPresenterOutput {
        var presentedHabitViewModels: [HabitViewModel]?
        var displayedHabitDidRemoveSuccessfullyIndex: Int?
        var displayedHabitDidRemoveFailureIndex: Int?
        
        func display(habitViewModels: [HabitViewModel]) {
            presentedHabitViewModels = habitViewModels
        }

        func displayHabitDidRemoveSuccessfully(by index: Int) {
            displayedHabitDidRemoveSuccessfullyIndex = index
        }

        func displayHabitDidRemoveFailure(by index: Int) {
            displayedHabitDidRemoveFailureIndex = index
        }
    }
}
