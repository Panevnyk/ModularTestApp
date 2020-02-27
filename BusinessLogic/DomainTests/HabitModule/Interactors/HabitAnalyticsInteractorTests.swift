//
//  HabitAnalyticsInteractorTests.swift
//  DomainTests
//
//  Created by Vladyslav Panevnyk on 10.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import Domain

final class HabitAnalyticsInteractorTests: XCTestCase {
    // MARK: - Mocks
    private let outputMock = HabitAnalyticsInteractorOutputMock()
    private let habitAnalyticsDBMock = HabitAnalyticsInteractorDBBoundaryMock()

    // MARK: - Tests sinceStart analytics
    func test_getHabitAnalyticsSinceStart() {
        makeSUT().loadHabitAnalytics(by: .sinceStart)

        let displayedHabitDatas = outputMock.displayedHabitDatas
        XCTAssertEqual(displayedHabitDatas?.count, 7)
        XCTAssertEqual(displayedHabitDatas![0].date, makeDate("12/30/2018"))
        XCTAssertEqual(displayedHabitDatas![1].date, makeDate("12/31/2018"))
        XCTAssertEqual(displayedHabitDatas![2].date, makeDate("01/01/2019"))
        XCTAssertEqual(displayedHabitDatas![3].date, makeDate("01/04/2019"))
        XCTAssertEqual(displayedHabitDatas![4].date, makeDate("01/25/2019"))
        XCTAssertEqual(displayedHabitDatas![5].date, makeDate("02/11/2019"))
        XCTAssertEqual(displayedHabitDatas![6].date, makeDate("02/13/2019"))
    }

    // MARK: - Tests by month analytics
    func test_getMonthlyHabitAnalytics_by02Month01Day() {
        makeSUT().loadHabitAnalytics(by: .month(makeDate("02/01/2019")))

        let displayedHabitDatas = outputMock.displayedHabitDatas
        XCTAssertEqual(displayedHabitDatas?.count, 2)
        XCTAssertEqual(displayedHabitDatas![0].date, makeDate("02/11/2019"))
        XCTAssertEqual(displayedHabitDatas![1].date, makeDate("02/13/2019"))
    }

    func test_getMonthlyHabitAnalytics_by02Month31Day() {
        makeSUT().loadHabitAnalytics(by: .month(makeDate("02/13/2019")))

        let displayedHabitDatas = outputMock.displayedHabitDatas
        XCTAssertEqual(displayedHabitDatas?.count, 2)
        XCTAssertEqual(displayedHabitDatas![0].date, makeDate("02/11/2019"))
        XCTAssertEqual(displayedHabitDatas![1].date, makeDate("02/13/2019"))
    }

    func test_getMonthlyHabitAnalytics_by01Month() {
        makeSUT().loadHabitAnalytics(by: .month(makeDate("01/20/2019")))

        let displayedHabitDatas = outputMock.displayedHabitDatas
        XCTAssertEqual(displayedHabitDatas?.count, 3)
        XCTAssertEqual(displayedHabitDatas![0].date, makeDate("01/01/2019"))
        XCTAssertEqual(displayedHabitDatas![1].date, makeDate("01/04/2019"))
        XCTAssertEqual(displayedHabitDatas![2].date, makeDate("01/25/2019"))
    }

    func test_getMonthlyHabitAnalytics_by12Month31Day() {
        makeSUT().loadHabitAnalytics(by: .month(makeDate("12/31/2018")))

        let displayedHabitDatas = outputMock.displayedHabitDatas
        XCTAssertEqual(displayedHabitDatas?.count, 2)
        XCTAssertEqual(displayedHabitDatas![0].date, makeDate("12/30/2018"))
        XCTAssertEqual(displayedHabitDatas![1].date, makeDate("12/31/2018"))
    }

    func test_getMonthlyHabitAnalytics_byMonthBeforeHabitCreated() {
        makeSUT().loadHabitAnalytics(by: .month(makeDate("11/30/2018")))
        XCTAssertEqual(outputMock.displayedHabitDatas?.count, 0)
    }

    func test_getMonthlyHabitAnalytics_byDateFromFuture() {
        makeSUT().loadHabitAnalytics(by: .month(makeDate("02/14/2019")))
        XCTAssertEqual(outputMock.displayedHabitDatas?.count, 0)
    }

    // MARK: - Tests by years analytics
    func test_getYearlyHabitAnalytics_byLastDayOfYear() {
        makeSUT().loadHabitAnalytics(by: .year(makeDate("12/31/2018")))

        let displayedHabitDatas = outputMock.displayedHabitDatas
        XCTAssertEqual(displayedHabitDatas?.count, 2)
        XCTAssertEqual(displayedHabitDatas![0].date, makeDate("12/30/2018"))
        XCTAssertEqual(displayedHabitDatas![1].date, makeDate("12/31/2018"))
    }

    func test_getYearlyHabitAnalytics_byFirstDayOfYear() {
        makeSUT().loadHabitAnalytics(by: .year(makeDate("01/01/2018")))

        let displayedHabitDatas = outputMock.displayedHabitDatas
        XCTAssertEqual(displayedHabitDatas?.count, 2)
        XCTAssertEqual(displayedHabitDatas![0].date, makeDate("12/30/2018"))
        XCTAssertEqual(displayedHabitDatas![1].date, makeDate("12/31/2018"))
    }

    func test_getYearlyHabitAnalytics_byYearBeforeHabitCreated() {
        makeSUT().loadHabitAnalytics(by: .year(makeDate("12/31/2017")))
        XCTAssertEqual(outputMock.displayedHabitDatas?.count, 0)
    }

    func test_getYearlyHabitAnalytics_byDateFromFuture() {
        makeSUT().loadHabitAnalytics(by: .year(makeDate("02/14/2019")))
        XCTAssertEqual(outputMock.displayedHabitDatas?.count, 0)
    }

    // MARK: - Helpers
    func makeSUT() -> HabitAnalyticsInteractor {
        let sut = HabitAnalyticsInteractor(output: outputMock,
                                           habitAnalyticsDB: habitAnalyticsDBMock,
                                           habit: makeHabit(),
                                           currentDate: makeDate("02/13/2019"))
        return sut
    }

    func makeHabit() -> Habit {
        return Habit(habitTitle: "Test",
                     creationDate: makeDate("12/30/2018"),
                     timePeriod: .day, 
                     schedule: HabitScheduleDay.allCases,
                     habitDataType: .boolean,
                     habitDatas: makeHabitDatas())
    }

    func makeHabitDatas() -> [HabitData] {
        return [HabitData(id: UUID(), value: true, date: makeDate("12/30/2018")),
                HabitData(id: UUID(), value: true, date: makeDate("12/31/2018")),
                HabitData(id: UUID(), value: true, date: makeDate("01/01/2019")),
                HabitData(id: UUID(), value: true, date: makeDate("01/04/2019")),
                HabitData(id: UUID(), value: true, date: makeDate("01/25/2019")),
                HabitData(id: UUID(), value: true, date: makeDate("02/11/2019")),
                HabitData(id: UUID(), value: true, date: makeDate("02/13/2019"))]
    }
}

// MARK: - Mocks
private extension HabitAnalyticsInteractorTests {
    final class HabitAnalyticsInteractorOutputMock: HabitAnalyticsInteractorOutput {
        var displayedHabitDatas: [HabitData]?

        func display(habitAnalytics habitDatas: [HabitData], by timePeriod: HabitAnalyticsTimePeriod) {
            displayedHabitDatas = habitDatas
        }
    }

    final class HabitAnalyticsInteractorDBBoundaryMock: HabitAnalyticsInteractorDBBoundary {

    }
}
