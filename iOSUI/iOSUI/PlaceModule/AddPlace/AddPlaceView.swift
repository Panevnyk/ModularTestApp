//
//  AddPlaceView.swift
//  iOSUI
//
//  Created by Vladyslav Panevnyk on 24.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import Combine
import BusinessLogic

struct AddPlaceView: View {
    // MARK: - Properties
    @Environment(\.presentationMode)
    var presentationMode: Binding<PresentationMode>
    @State
    private var placeName: String = ""
    
    private var interactor: PlaceInteractorInput?
    
    // MARK: - Init
    public init(interactor: PlaceInteractorInput?) {
        self.interactor = interactor
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Add place")
                .font(.largeTitle)
            TextField("Place name", text: $placeName)
                .frame(height: 40)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            AddButton(isDisabled: .constant($placeName.wrappedValue.isEmpty),
                      addAction: addPlaceAction)
        }
        .padding(.horizontal, 15)
    }
    
    func makePlace(name: String) -> Place {
        return Place(id: UUID(),
                     name: name,
                     placeCoordinate: PlaceCoordinate(lat: 0.0, lng: 0.0),
                     createDate: Date())
    }
}

// MARK: - Actions
private extension AddPlaceView {
    func addPlaceAction() {
        let place = self.makePlace(name: self.$placeName.wrappedValue)
        self.interactor?.add(place: place)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddPlaceView_Previews: PreviewProvider {
    static var previews: some View {
        AddPlaceView(interactor: nil)
    }
}
