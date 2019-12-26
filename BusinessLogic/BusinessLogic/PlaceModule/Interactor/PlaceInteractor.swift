//
//  PlaceService.swift
//  BusinessLogic
//
//  Created by Vladyslav Panevnyk on 13.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

public protocol PlaceInteractorInput: class {
    func getAllSortedPlaces()
    func add(place: Place)
    func removePlace(by index: Int)
}

public protocol PlaceDBBoundary {
    func getAllPlaces() -> [Place]
    func add(place: Place)
    func remove(place: Place)
}

public protocol PlaceInteractorOutput {
    func display(places: [Place])
}

public class PlaceInteractor: PlaceInteractorInput {
    // MARK: - Properties
    private let output: PlaceInteractorOutput
    private let placeDB: PlaceDBBoundary
    
    private var displayedPlaces: [Place] = []
    
    // MARK: - Inits
    public init(output: PlaceInteractorOutput, placeDB: PlaceDBBoundary) {
        self.output = output
        self.placeDB = placeDB
    }
    
    // MARK: - Public methods
    public func getAllSortedPlaces() {
        let places = placeDB.getAllPlaces()
        displayedPlaces = places
        output.display(places: places)
    }
    
    public func add(place: Place) {
        placeDB.add(place: place)
    }
    
    public func removePlace(by index: Int) {
        guard displayedPlaces.count > index else { return }
        
        let placeForRemove = displayedPlaces[index]
        placeDB.remove(place: placeForRemove)
    }
}
