//
//  PlaceService.swift
//  BusinessLogic
//
//  Created by Vladyslav Panevnyk on 13.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

public protocol PlaceInteractorInput: class {
    func getAllSortedPlaces()
}

public protocol PlaceInteractorOutput {
    func display(places: [Place])
}

public class PlaceInteractor: PlaceInteractorInput {
    // MARK: - Properties
    private let output: PlaceInteractorOutput
    
    // MARK: - Inits
    public init(output: PlaceInteractorOutput) {
        self.output = output
    }
    
    // MARK: - Public methods
    public func getAllSortedPlaces() {
        output.display(places: makePlaces())
    }
    
    // MARK: - Helpers
    private func makePlaces() -> [Place] {
        return [Place(id: 0,
                      name: "Ivano-Frankivsk",
                      placeCoordinate: PlaceCoordinate(lat: 48.9215, lng: 24.70972),
                      createDate: Date()),
                Place(id: 1,
                      name: "Lviv",
                      placeCoordinate: PlaceCoordinate(lat: 49.83826, lng: 24.02324),
                      createDate: Date()),
                Place(id: 2,
                      name: "Kyiv",
                      placeCoordinate: PlaceCoordinate(lat: 50.45466, lng: 30.5238),
                      createDate: Date())]
    }
}
