//
//  PlacePresenter.swift
//  HabbityIOSUI
//
//  Created by Vladyslav Panevnyk on 16.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import UIKit
import HabbityDomain

public protocol HabitListPresenterOutput {
    func display(habitViewModels: [HabitViewModel])
    func displayHabitDidRemoveSuccessfully(by index: Int)
    func displayHabitDidRemoveFailure(by index: Int)
}

final public class HabitListPresenter: HabitListInteractorOutput {
    public var view: HabitListPresenterOutput?
    
    public init() {}
    
    public func present(habits: [Habit]) {
        view?.display(habitViewModels: habits.enumerated().compactMap {
            HabitViewModel(id: $0, title: $1.habitTitle, isSelected: false)
        })
    }

    public func presentHabitDidRemoveSuccessfully(by index: Int) {
        view?.displayHabitDidRemoveSuccessfully(by: index)
    }

    public func presentHabitDidRemoveFailure(by index: Int) {
        view?.displayHabitDidRemoveFailure(by: index)
    }
}
