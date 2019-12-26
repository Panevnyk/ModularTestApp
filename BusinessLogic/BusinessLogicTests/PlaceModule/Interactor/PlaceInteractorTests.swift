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
        let places = makePlaces(names: ["Place1", "Place2", "Place3"])
        let sut = makeSUT(places: places)
        
        sut.getAllSortedPlaces()
        
        XCTAssertEqual(output.displayedPlaces?.count, 3)
        XCTAssertEqual(output.displayedPlaces?[0].name, "Place1")
        XCTAssertEqual(output.displayedPlaces?[1].name, "Place2")
        XCTAssertEqual(output.displayedPlaces?[2].name, "Place3")
    }
    
    func testAddPlaceIsDBCalled() {
        let sut = makeSUT()
        let place = makePlace(name: "Test add place")
        
        sut.add(place: place)
        
        XCTAssertEqual(placeDBBoundaryMock.addedPlace?.name, "Test add place")
    }
    
    func testRemovePlace_fromEmptyArray_expectedNothingRemoved() {
        let sut = makeSUT()
        
        sut.getAllSortedPlaces()
        sut.removePlace(by: 0)
        
        XCTAssertEqual(placeDBBoundaryMock.removedPlace?.name, nil)
    }
    
    func testRemovePlace_byOutOfBoundsIndex_expectedNothingRemoved() {
        let places = makePlaces(names: ["Place1", "Place2", "Place3"])
        let sut = makeSUT(places: places)
        
        sut.getAllSortedPlaces()
        sut.removePlace(by: 3)
        
        XCTAssertEqual(placeDBBoundaryMock.removedPlace?.name, nil)
    }
    
    func testRemovePlace_withCorrectIndex_expectedObjectSuccessfulyRemoved() {
        let places = makePlaces(names: ["Place1", "Place2", "Place3"])
        let sut = makeSUT(places: places)
        
        sut.getAllSortedPlaces()
        sut.removePlace(by: 1)
        
        XCTAssertEqual(placeDBBoundaryMock.removedPlace?.name, "Place2")
    }

    // MARK: - Helpers
    func makeSUT(places: [Place] = []) -> PlaceInteractorInput {
        placeDBBoundaryMock.mockedPlaces = places
        let sut = PlaceInteractor(output: output, placeDB: placeDBBoundaryMock)
        return sut
    }
    
    func makePlaces(names: [String]) -> [Place] {
        return names.compactMap { makePlace(name: $0) }
    }
    
    func makePlace(name: String) -> Place {
        return Place(id: UUID(),
                     name: name,
                     placeCoordinate: PlaceCoordinate(lat: 0.0, lng: 0.0),
                     createDate: Date())
    }
}

// MARK: - PlaceInteractorOutputMock
private extension PlaceInteractorTests {
    class PlaceInteractorOutputMock: PlaceInteractorOutput {
        var displayedPlaces: [Place]?
        
        func display(places: [Place]) {
            displayedPlaces = places
        }
    }
}

// MARK: - PlaceDBBoundaryMock
private extension PlaceInteractorTests {
    class PlaceDBBoundaryMock: PlaceDBBoundary {
        var mockedPlaces: [Place] = []
        var addedPlace: Place?
        var removedPlace: Place?
        
        func getAllPlaces() -> [Place] {
            return mockedPlaces
        }
        
        func add(place: Place) {
            addedPlace = place
        }
        
        func remove(place: Place) {
            removedPlace = place
        }
    }
}
