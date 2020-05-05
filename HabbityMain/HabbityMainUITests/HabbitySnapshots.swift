//
//  HabbityMainUITests.swift
//  HabbityMainUITests
//
//  Created by Vladyslav Panevnyk on 30.04.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import XCTest

final class HabbitySnapshots: XCTestCase {
    // MARK: - Properties
    private var app: XCUIApplication!

    // MARK: - Setup methods
    override func setUp() {
        continueAfterFailure = false

        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    override func tearDown() {
        app = nil
    }

    // MARK: - UITests
    func testCreateSnaphots() {
        // Add MainHabbityScreen1 snapshot
        snapshot("MainHabbityScreen")

        openCreatHabitScreen()

        // Add EmptyCreateHabitScreen snapshot
        snapshot("EmptyCreateHabitScreen")

        selectTitle()
        selectTimePeriod()
        selectDays()

        // Add FilledCreateHabitScreen snapshot
        snapshot("FilledCreateHabitScreen")

        tapAddButton()
    }

    private func openCreatHabitScreen() {
        app.navigationBars["Habits"].buttons["User Profile"].tap()
    }

    private func selectTitle() {
        app.staticTexts["Habit title"].tap()
        app.keys["S"].tap()
        app.keys["w"].tap()
        app.keys["i"].tap()
        app.keys["m"].tap()
        app.keys["m"].tap()
        app.keys["i"].tap()
        app.keys["n"].tap()
        app.keys["g"].tap()
        app.buttons["Return"].tap()
    }

    private func selectTimePeriod() {
        app.staticTexts["Day"].tap()
        app.sheets["Habit time period"].scrollViews.otherElements.buttons["Week"].tap()
    }

    private func selectDays() {
        app.staticTexts["M"].tap()
        app.staticTexts["W"].tap()
        app.staticTexts["F"].tap()
    }

    private func tapAddButton() {
        app.buttons["ADD"].tap()
    }
}
