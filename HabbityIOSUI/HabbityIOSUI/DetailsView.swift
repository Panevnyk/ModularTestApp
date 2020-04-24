//
//  DetailsView.swift
//  HabbityIOSUI
//
//  Created by Vladyslav Panevnyk on 17.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI

struct DetailsView: View {
    @Environment(\.presentationMode) var presentation

    var body: some View {
        Group {
            Button("Go Back") {
                self.presentation.wrappedValue.dismiss()
            }
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
    }
}
