//
//  PlaceAssembly.swift
//  iOSMain
//
//  Created by Vladyslav Panevnyk on 17.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import BusinessLogic
import CoreDataDB
import iOSUI


final class PlaceAssembly {
    let presenter: PlaceInteractorOutput
    let interactor: PlaceInteractorInput
    let view: PlaceListView
    
    init(placeDB: PlaceDBBoundary) {
        let presenter = PlacePresenter()
        let interactor = PlaceInteractor(output: presenter,
                                         placeDB: placeDB)
        let view = PlaceListView(interactor: interactor)
        presenter.view = view
        
        self.presenter = presenter
        self.interactor = interactor
        self.view = view
    }
}
