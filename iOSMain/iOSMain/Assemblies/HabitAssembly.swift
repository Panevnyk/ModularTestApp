//
//  PlaceAssembly.swift
//  iOSMain
//
//  Created by Vladyslav Panevnyk on 17.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import Domain
import CoreDataDB
import iOSUI

final class HabitAssembly {
    let presenter: HabitListInteractorOutput
    let interactor: HabitListInteractorInput
    var view: HabitsListView
    
    init(habitListDB: HabitListDBBoundary, coordinatorDelegate: HabitsListViewCoordinatorDelegate?) {
        let presenter = HabitListPresenter()
        let interactor = HabitListInteractor(output: presenter,
                                             habitListDB: habitListDB)
        let view = HabitsListView(interactor: interactor, coordinatorDelegate: coordinatorDelegate)
        presenter.view = view
        
        self.presenter = presenter
        self.interactor = interactor
        self.view = view
    }
}
