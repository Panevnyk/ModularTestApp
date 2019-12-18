//
//  PlacePresenter.swift
//  iOSUI
//
//  Created by Vladyslav Panevnyk on 16.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import BusinessLogic

public protocol PlacePresenterOutput {
    func display(placeViewModels: [PlaceViewModel])
}

final public class PlacePresenter: PlaceInteractorOutput {
    public var view: PlacePresenterOutput?
    
    public init() {}
    
    public func display(places: [Place]) {
        view?.display(placeViewModels: places.map { PlaceViewModel(id: $0.id, name: $0.name) })
    }
}
