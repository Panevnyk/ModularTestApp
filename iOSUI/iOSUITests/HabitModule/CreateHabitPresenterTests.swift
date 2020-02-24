//
//  CreateHabitPresenterTests.swift
//  iOSUITests
//
//  Created by Vladyslav Panevnyk on 12.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import BusinessLogic
@testable import iOSUI

final class CreateHabitPresenterTests: XCTestCase {
    // MARK: - Mocks
    private let output = CreateHabitPresenterOutputMock()
    private let createHabitDBMock = CreateHabitDBBoundaryMock()

    // MARK: - Tests

    // MARK: - Helpers
    func makeSUT() -> CreateHabitPresenter {
        let sut = CreateHabitPresenter()
        return sut
    }
}

// MARK: - Mock
private extension CreateHabitPresenterTests {
    final class CreateHabitPresenterOutputMock: CreateHabitPresenterOutput {
        func display(habit: Habit) {}
    }

    final class CreateHabitDBBoundaryMock: CreateHabitDBBoundary {
        func addHabit(_ habit: Habit) {}
    }
}
