//
//  Place.swift
//  BusinessLogic
//
//  Created by Vladyslav Panevnyk on 13.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

public struct Place {
    public var id: UUID
    public var name: String
    public var placeCoordinate: PlaceCoordinate
    public var createDate: Date
    
    public init(id: UUID,
                name: String,
                placeCoordinate: PlaceCoordinate,
                createDate: Date) {
        self.id = id
        self.name = name
        self.placeCoordinate = placeCoordinate
        self.createDate = createDate
    }
}
