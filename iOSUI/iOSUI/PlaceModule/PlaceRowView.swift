//
//  PlaceRowView.swift
//  iOSUI
//
//  Created by Vladyslav Panevnyk on 17.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

struct PlaceRowView: View {
    var viewModel: PlaceViewModel
    
    var body: some View {
        Text(viewModel.name)
    }
}

struct PlaceRowView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceRowView(viewModel: PlaceViewModel(id: 0, name: "Test"))
    }
}
