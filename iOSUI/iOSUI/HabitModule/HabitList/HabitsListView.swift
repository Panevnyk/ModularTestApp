//
//  PlaceView.swift
//  iOSUI
//
//  Created by Vladyslav Panevnyk on 17.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import Combine
import BusinessLogic

// FIXME: - Should be REMOVED, big crutch
var interactor2: CreateHabitInteractor?

public struct HabitsListView: View {
    // MARK: - Properties
    @State
    private var selection: Int? = nil
    @State
    var showingCreateHabit = false
    @ObservedObject
    private var dataSource = PlaceDataSource()
    
    private weak var interactor: PlaceInteractorInput?

    // MARK: - Init
    public init(interactor: PlaceInteractorInput?) {
        self.interactor = interactor
        setupUI()
    }
    
    // MARK: - Body
    public var body: some View {
        NavigationView {
            VStack {
                List() {
                    ForEach(dataSource.placeViewModels) { viewModel in
                        HabitRowView(viewModel: viewModel)
                    }.onDelete(perform: deleteItems)
                }
            }
            .navigationBarTitle(Text("Habits"))
            .navigationBarItems(trailing:
                CreateHabitButton(action: { self.showingCreateHabit.toggle() }))
            .sheet(isPresented: $showingCreateHabit, onDismiss: fetchData) {
                self.createHabitView()
            }
        }
        .onAppear(perform: fetchData)
    }

    func createHabitView() -> CreateHabitView {
        // FIXME: - Should be moved to iOSMain
        let presenter = CreateHabitPresenter()
        let db = CreateHabitDBBoundaryMock()
        let interactor12 = CreateHabitInteractor(output: presenter,
                                                createHabitDB: db)
        let view = CreateHabitView(interactor: interactor12)
        presenter.view = view
        interactor2 = interactor12
        return view
    }

    private func fetchData() {
        interactor?.getAllSortedPlaces()
    }
    
    private func deleteItems(at indexSet: IndexSet) {
        indexSet.forEach { index in
            interactor?.removePlace(by: index)
        }
        dataSource.placeViewModels.remove(atOffsets: indexSet)
    }
}

// MARK: UI methods
private extension HabitsListView {
    func setupUI() {
        UITableView.appearance().tableFooterView = UIView()
    }
}

// MARK: PlacePresenterOutput
extension HabitsListView: PlacePresenterOutput {
    public func display(placeViewModels: [PlaceViewModel]) {
        dataSource.placeViewModels = placeViewModels
    }
}

// MARK: - PreviewProvider
struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsListView(interactor: nil)
    }
}
