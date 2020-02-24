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
        HStack(alignment: .top, spacing: 4) {
            VStack(alignment: .leading, spacing: 16) {
                Spacer()
                Text("12%")
                Text(viewModel.title)
                Spacer()
            }

            Spacer()

            VStack(alignment: .leading, spacing: 0) {
                Spacer()
                RadioButton(isSelected: false)
                Spacer()
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 84)
        .padding(.horizontal, 16)
        .background(Color(.quaternarySystemFill))
        .cornerRadius(6)
    }
}

struct HabitRowView_Previews: PreviewProvider {
    static var previews: some View {
        HabitRowView(viewModel: HabitViewModel(id: 0, title: "Morning exercise"))
    }
}
