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
    // MARK: - Mocks
    private let output = PlaceInteractorOutputMock()
    private let placeDBBoundaryMock = PlaceDBBoundaryMock()
    
    // MARK: - Tests
    func testIsDisplayAllSortedPlaces() {
        let sut = makeSUT()
        sut.getAllSortedPlaces()
        XCTAssertTrue(output.isGetAllSortedPlacesCalled)
    }
    
    // MARK: - Helpers
    func makeSUT() -> PlaceInteractorInput {
        let sut = PlaceInteractor(output: output, placeDB: placeDBBoundaryMock)
        return sut
    }
}

// MARK: - PlaceInteractorOutputMock
private extension PlaceInteractorTests {
    class PlaceInteractorOutputMock: PlaceInteractorOutput {
        var isGetAllSortedPlacesCalled = false
        
        func display(places: [Place]) {
            isGetAllSortedPlacesCalled = true
        }
    }
}

// MARK: - PlaceDBBoundaryMock
private extension PlaceInteractorTests {
    class PlaceDBBoundaryMock: PlaceDBBoundary {
        func getAllPlaces() -> [Place] {
            return []
        }
        
        func addPlace(_ place: Place) {}
    }
}
