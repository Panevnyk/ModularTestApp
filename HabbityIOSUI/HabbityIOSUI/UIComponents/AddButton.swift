//
//  AddButton.swift
//  HabbityIOSUI
//
//  Created by Vladyslav Panevnyk on 26.12.2019.
//  Copyright © 2019 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import Combine

struct AddButton: View {
    @Binding
    var isDisabled: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("ADD")
                .foregroundColor(.white)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 40)
                .background(isDisabled ? Color.kBlueDisabled : Color.kBlue)
                .cornerRadius(4)
        }
        .disabled(isDisabled)
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton(isDisabled: .constant(false), action: {})
    }
}
