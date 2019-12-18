//
//  PlaceInteractorTests.swift
//  BusinessLogic
//
//  Created by Vladyslav Panevnyk on 16.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import BusinessLogic

final class PlaceInteractorTests: XCTestCase {
    private let output = PlaceInteractorOutputMock()
    
    // MARK: - Tests
    func testIsDisplayAllSortedPlaces() {
        let sut = makeSUT()
        sut.getAllSortedPlaces()
        XCTAssertTrue(output.isGetAllSortedPlacesCalled)
    }
    
    // MARK: - Helpers
    func makeSUT() -> PlaceInteractorInput {
        let sut = PlaceInteractor(output: output)
        return sut
    }
}

// MARK: - Mocks
private extension PlaceInteractorTests {
    class PlaceInteractorOutputMock: PlaceInteractorOutput {
        var isGetAllSortedPlacesCalled = false
        
        func display(places: [Place]) {
            isGetAllSortedPlacesCalled = true
        }
    }
}
