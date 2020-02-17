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
//        let placesMO: [PlaceMO] = getEntities() ?? []
//        return placesMO.compactMap { makePlace(from: $0) }
        return []
    }

    public func add(place: Place) {
//        let placeMO = makePlaceMO(from: place, backgroundContext: backgroundContext)
//        save(object: placeMO)
    }

    public func remove(place: Place) {
//        guard let placeMOForRemove = fetchPlaceMOFromDB(by: place, backgroundContext: backgroundContext)  else { return }
//        remove(object: placeMOForRemove)
    }
}

//// MARK: - Helper methods
//private extension CoreDataService {
//    func fetchPlaceMOFromDB(by place: Place, backgroundContext: NSManagedObjectContext) -> PlaceMO? {
//        let predicate = NSPredicate(format: "id = %@", place.id.uuidString)
//        do {
//            return try backgroundContext.entity(withType: PlaceMO.self, predicate: predicate)
//        } catch let error {
//            print("CoreDataService module fail to fetch place object error: \(error)")
//        }
//        return nil
//    }
//
//    func makePlace(from placeMO: PlaceMO) -> Place? {
//        guard let id = placeMO.id,
//            let name = placeMO.name,
//            let createDate = placeMO.createDate,
//            let lat = placeMO.placeCoordinateMO?.lat,
//            let lng = placeMO.placeCoordinateMO?.lng else { return nil }
//
//        let placeCoordinate = PlaceCoordinate(lat: lat, lng: lng)
//        let place = Place(id: id, name: name, placeCoordinate: placeCoordinate, createDate: createDate)
//        return place
//    }
//
//    func makePlaceMO(from place: Place, backgroundContext: NSManagedObjectContext) -> PlaceMO {
//        let placeCoordinateMO = PlaceCoordinateMO(context: backgroundContext)
//        placeCoordinateMO.lat = place.placeCoordinate.lat
//        placeCoordinateMO.lng = place.placeCoordinate.lng
//
//        let placeMO = PlaceMO(context: backgroundContext)
//        placeMO.id = place.id
//        placeMO.name = place.name
//        placeMO.createDate = place.createDate
//        placeMO.placeCoordinateMO = placeCoordinateMO
//
//        return placeMO
//    }
//}
