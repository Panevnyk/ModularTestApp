//
//  CreateHabitPresenterTests.swift
//  iOSUITests
//
//  Created by Vladyslav Panevnyk on 12.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import Domain
@testable import iOSUI

final class CreateHabitPresenterTests: XCTestCase {
    // MARK: - Mocks
    private let output = CreateHabitPresenterOutputMock()
    private let createHabitDBMock = CreateHabitDBBoundaryMock()

    // MARK: - Tests
    func test_presentHabitAddedSuccessfuly() {
        makeSUT().presentHabitAddedSuccessfuly()
        XCTAssertEqual(output.isHabitAddedSuccessfully, true)
    }

    func test_presentHabitAddingFailure() {
        makeSUT().presentHabitAddingFailure()
        XCTAssertEqual(output.isHabitAddingFailure, true)
    }

    // MARK: - Helpers
    func makeSUT() -> CreateHabitPresenter {
        let sut = CreateHabitPresenter()
        sut.view = output
        return sut
    }
}

// MARK: - Mock
private extension CreateHabitPresenterTests {
    final class CreateHabitPresenterOutputMock: CreateHabitPresenterOutput {
        var isHabitAddedSuccessfully = false
        var isHabitAddingFailure = false

        func displayHabitAddedSuccessfuly() {
            isHabitAddedSuccessfully = true
        }

        func displayHabitAddingFailure() {
            isHabitAddingFailure = true
        }
    }

    final class CreateHabitDBBoundaryMock: CreateHabitDBBoundary {
        func addHabit(_ habit: Habit) {}
    }
}
