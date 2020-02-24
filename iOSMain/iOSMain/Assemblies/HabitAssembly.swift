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

final class HabitAssembly {
    let presenter: HabitListInteractorOutput
    let interactor: HabitListInteractorInput
    let view: HabitsListView
    
    init(habitListDB: HabitListDBBoundary) {
        let presenter = HabitListPresenter()
        let interactor = HabitListInteractor(output: presenter,
                                             habitListDB: habitListDB)
        let view = HabitsListView(interactor: interactor)
        presenter.view = view
        
        self.presenter = presenter
        self.interactor = interactor
        self.view = view
    }
}
