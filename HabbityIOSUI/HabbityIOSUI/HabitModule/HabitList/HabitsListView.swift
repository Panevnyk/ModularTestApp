//
//  PlaceView.swift
//  HabbityIOSUI
//
//  Created by Vladyslav Panevnyk on 17.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import Combine
import HabbityDomain

public protocol HabitsListViewCoordinatorDelegate {
    func createHabitViewAction(completion: OptionalClosure)
}

public struct HabitsListView: View {
    // MARK: - Properties

    // Boundaries
    private var interactor: HabitListInteractorInput?
    private var coordinatorDelegate: HabitsListViewCoordinatorDelegate?

    // UI
    @State
    private var selection: Int? = nil
    @ObservedObject
    private var dataSource = HabitDataSource()

    // MARK: - Init
    public init(interactor: HabitListInteractorInput?, coordinatorDelegate: HabitsListViewCoordinatorDelegate?) {
        self.interactor = interactor
        self.coordinatorDelegate = coordinatorDelegate
        setupUI()
    }
    
    // MARK: - Body
    public var body: some View {
        NavigationView {
            VStack {
                List() {
                    ForEach(dataSource.habitViewModels) { viewModel in
                        HabitRowView(viewModel: viewModel,
                                     didSelect: self.didSelectItem)
                    }.onDelete(perform: deleteItems)
                }
            }
            .navigationBarTitle(Text("Habits"))
            .navigationBarItems(trailing:
                CreateHabitButton(action: { self.createHabitAction() }))
        }
        .onAppear(perform: fetchData)
    }

    // TODO: - Shoud be used after close create action
    private func fetchData() {
        interactor?.loadHabits()
    }

    private func createHabitAction() {
        coordinatorDelegate?.createHabitViewAction {
            self.fetchData()
        }
    }

    func didSelectItem(_ isSelected: Bool, _ viewModel: HabitViewModel) {
        print(isSelected)
    }
    
    private func deleteItems(at indexSet: IndexSet) {
        indexSet.forEach { index in
            interactor?.removeHabit(by: index)
        }
        dataSource.habitViewModels.remove(atOffsets: indexSet)
    }
}

// MARK: UI methods
private extension HabitsListView {
    func setupUI() {
        UITableView.appearance().allowsSelection = false
        UITableViewCell.appearance().selectionStyle = .none
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
    }
}

// MARK: PlacePresenterOutput
extension HabitsListView: HabitListPresenterOutput {
    public func display(habitViewModels: [HabitViewModel]) {
        DispatchQueue.main.async {
            self.dataSource.habitViewModels = habitViewModels
        }
    }

    public func displayHabitDidRemoveSuccessfully(by index: Int) {

    }

    public func displayHabitDidRemoveFailure(by index: Int) {

    }
}

// MARK: - PreviewProvider
struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsListView(interactor: nil, coordinatorDelegate: nil)
    }
}
