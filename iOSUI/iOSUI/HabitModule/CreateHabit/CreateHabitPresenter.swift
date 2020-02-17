//
//  CreateHabitPresenter.swift
//  iOSUI
//
//  Created by Vladyslav Panevnyk on 11.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import BusinessLogic

protocol CreateHabitPresenterOutput {
}

final class CreateHabitPresenter: CreateHabitInteractorOutput {
    func present(habit: Habit) {
        
    }

    var view: CreateHabitPresenterOutput?

    func habitAddedSuccessfuly() {
        print("!!! SUCCESS YEAH")
    }
    
    func habitAddingFailure() {
        print("!!! Failure ((((")
    }
}

class CreateHabitDBBoundaryMock: CreateHabitDBBoundary {
    func addHabit(_ habit: Habit) {}
}
