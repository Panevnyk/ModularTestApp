//
//  CoreDataManager+PlaceDBBoundary.swift
//  CoreDataDB
//
//  Created by Vladyslav Panevnyk on 20.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import CoreData
import BusinessLogic

extension CoreDataService: PlaceDBBoundary {
    public func getAllPlaces() -> [Place] {
        // add dummy places
//        makePlaces().forEach { addPlace($0) }
        
        let placesMO: [PlaceMO] = getEntities() ?? []
        
        let places: [Place] = placesMO.compactMap { (placeMO) in
            guard let id = placeMO.id,
                let name = placeMO.name,
                let createDate = placeMO.createDate,
                let lat = placeMO.placeCoordinateMO?.lat,
                let lng = placeMO.placeCoordinateMO?.lng else { return nil }
            
            let placeCoordinate = PlaceCoordinate(lat: lat, lng: lng)
            let place = Place(id: id, name: name, placeCoordinate: placeCoordinate, createDate: createDate)

            return place
        }
        
        return places
    }
    
    public func addPlace(_ place: Place) {
        let placeCoordinateMO = PlaceCoordinateMO(context: backgroundContext)
        placeCoordinateMO.lat = place.placeCoordinate.lat
        placeCoordinateMO.lng = place.placeCoordinate.lng
        
        let placeMO = PlaceMO(context: backgroundContext)
        placeMO.id = place.id
        placeMO.name = place.name
        placeMO.createDate = place.createDate
        placeMO.placeCoordinateMO = placeCoordinateMO
        
        save(object: placeMO)
    }
}

extension CoreDataService {
    private func makePlaces() -> [Place] {
        return [Place(id: UUID(),
                      name: "Ivano-Frankivsk",
                      placeCoordinate: PlaceCoordinate(lat: 48.9215, lng: 24.70972),
                      createDate: Date()),
                Place(id: UUID(),
                      name: "Lviv",
                      placeCoordinate: PlaceCoordinate(lat: 49.83826, lng: 24.02324),
                      createDate: Date()),
                Place(id: UUID(),
                      name: "Kyiv",
                      placeCoordinate: PlaceCoordinate(lat: 50.45466, lng: 30.5238),
                      createDate: Date())]
    }
}
