//
//  HabitTextField.swift
//  iOSUI
//
//  Created by Vladyslav Panevnyk on 12.02.2020.
//  Copyright © 2020 Vladyslav Panevnyk. All rights reserved.
//

import SwiftUI
import Combine

struct HabitTextField: View {
    var placeHolder: String
    @Binding
    var inputText: String
    @State
    private var isEditing = false
    private var isPlaceholderOnTheTop: Binding<Bool> {
        Binding(get: {
            self.isEditing || !self.inputText.isEmpty
        }) { (newVal) in }
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                Text(self.placeHolder)
                    .foregroundColor(self.isPlaceholderOnTheTop.wrappedValue ? Color.black : Color.gray)
                    .offset(x: 0, y: self.isPlaceholderOnTheTop.wrappedValue ? 0 : 29)
                    .scaleEffect(self.isPlaceholderOnTheTop.wrappedValue ? 0.8 : 1, anchor: UnitPoint(x: 0, y: 0))

                TextField("", text: self.$inputText, onEditingChanged: { isEditing in
                    withAnimation(.easeInOut) {
                        self.isEditing.toggle()
                    }
                })
                    .frame(height: 40)
                Divider()
            }

        }
    }
}

struct HabitTextField_Previews: PreviewProvider {
    static var previews: some View {
        HabitTextField(placeHolder: "Test placeholder", inputText: .constant(""))
    }
}
