//
//  ColorPickerView.swift
//  Sailor
//
//  Created by Gordon Aspin on 1/12/25.
//

import SwiftUI

struct ColorPickerView: View {
    var title: String
    @Binding var selectedColor: Int
    let settings = ViewSettings()
    
    var body: some View {
        Picker(title, selection: $selectedColor) {
            ForEach(0..<settings.colors.count, id: \.self) { i in
                HStack {
                    Circle()
                        .fill(settings.colors[i].color)
                        .frame(width: 20, height: 20)
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 1) // Add border with black color
                        )
                    Text(settings.colors[i].name)
                        .tag(i)
                }
            }
        }
        .pickerStyle(InlinePickerStyle())
    }
}

#Preview {
    struct Preview: View {
        @State var selectedColor: Int = 0
        var body: some View {
            Form {
                ColorPickerView(title: "Color", selectedColor: $selectedColor)
            }
        }
    }
    return Preview()
}
