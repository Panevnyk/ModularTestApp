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

public protocol PlaceDBBoundary {
    func getAllPlaces() -> [Place]
    func addPlace(_ place: Place)
}

public protocol PlaceInteractorOutput {
    func display(places: [Place])
}

public class PlaceInteractor: PlaceInteractorInput {
    // MARK: - Properties
    private let output: PlaceInteractorOutput
    private let placeDB: PlaceDBBoundary
    
    // MARK: - Inits
    public init(output: PlaceInteractorOutput, placeDB: PlaceDBBoundary) {
        self.output = output
        self.placeDB = placeDB
    }
    
    // MARK: - Public methods
    public func getAllSortedPlaces() {
        let places = placeDB.getAllPlaces()
        output.display(places: places)
    }
}
