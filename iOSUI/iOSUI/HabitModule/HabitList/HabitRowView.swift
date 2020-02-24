//
//  PlaceRowView.swift
//  iOSUI
//
//  Created by Vladyslav Panevnyk on 17.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

struct HabitRowView: View {
    var viewModel: HabitViewModel
    
    var body: some View {
        Text(viewModel.title)
    }
}

struct HabitRowView_Previews: PreviewProvider {
    static var previews: some View {
        HabitRowView(viewModel: HabitViewModel(id: 0, title: "Test"))
    }
}
