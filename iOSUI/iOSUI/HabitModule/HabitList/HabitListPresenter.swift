//
//  PlacePresenter.swift
//  iOSUI
//
//  Created by Vladyslav Panevnyk on 16.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import BusinessLogic

public protocol HabitListPresenterOutput {
    func display(habitViewModels: [HabitViewModel])
}

final public class HabitListPresenter: HabitListInteractorOutput {
    public var view: HabitListPresenterOutput?
    
    public init() {}
    
    public func present(habits: [Habit]) {
        view?.display(habitViewModels: habits.enumerated().compactMap {
            HabitViewModel(id: $0, title: $1.habitTitle)
        })
    }
}
