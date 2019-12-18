//
//  PlacePresenterTests.swift
//  iOSUITests
//
//  Created by Vladyslav Panevnyk on 18.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import XCTest
@testable import BusinessLogic
@testable import iOSUI

final class PlacePresenterTests: XCTestCase {
    // MARK: - Mocks
    private let output = PlacePresenterOutputMock()
    
    // MARK: - Tests
    func testDisplayPlaces() {
        let sut = makeSUT()
        let place1 = makePlace(id: 0, name: "Test1")
        let place2 = makePlace(id: 1, name: "Test2")
        
        sut.display(places: [place1, place2])
        
        XCTAssertEqual(output.presentedPlaceViewModels?.count, 2)
        XCTAssertEqual(output.presentedPlaceViewModels?.first?.id, 0)
        XCTAssertEqual(output.presentedPlaceViewModels?.last?.id, 1)
        XCTAssertEqual(output.presentedPlaceViewModels?.first?.name, "Test1")
        XCTAssertEqual(output.presentedPlaceViewModels?.last?.name, "Test2")
    }
    
    // MARK: - Helper
    func makeSUT() -> PlaceInteractorOutput {
        let sut = PlacePresenter()
        sut.view = output
        return sut
    }
    
    func makePlace(id: Int, name: String) -> Place {
        return Place(id: id,
                     name: name,
                     placeCoordinate: PlaceCoordinate(lat: 0.0, lng: 0.0),
                     createDate: Date())
    }
}

// MARK: - Mocks
private extension PlacePresenterTests {
    class PlacePresenterOutputMock: PlacePresenterOutput {
        var presentedPlaceViewModels: [PlaceViewModel]?
        
        func display(placeViewModels: [PlaceViewModel]) {
            presentedPlaceViewModels = placeViewModels
        }
    }
}
