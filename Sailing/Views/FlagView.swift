//
//  FlagView.swift
//  Sailing
//
//  Created by Gordon Aspin on 4/17/25.
//

import SwiftUI

struct FlagView: View {
    let flags = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    let pennants = Array("1234567890")
    let flagColumns = [
        GridItem(.flexible()), GridItem(.flexible()),
        GridItem(.flexible()), GridItem(.flexible()),
    ]
    let pennantColumns = [
        GridItem(.flexible()), GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        ScrollView {
            Spacer()
            Text("Flags")
            LazyVGrid(columns: flagColumns, spacing: 10) {
                ForEach(flags, id: \.self) { flag in
                    HStack {
                        Spacer()
                        Text(String(flag))
                            .foregroundColor(.gray)
                            .font(.system(.headline))
                            .padding(4)
                            .frame(width: 32, height: 32)
                        Image(String(flag))
                            .resizable()
                            .scaledToFit()
                            .padding(4)
                    }
                    .border(Color.gray, width: 1)
                    .background(.white)
                }
            }
            .padding(10) // Padding around the entire grid
            Spacer()
            Text("Pennants")
            LazyVGrid(columns: pennantColumns, spacing: 10) {
                ForEach(pennants, id: \.self) { flag in
                    HStack {
                        Spacer()
                        Text(String(flag))
                            .foregroundColor(.gray)
                            .font(.system(.headline))
                            .padding(4)
                            .frame(width: 32, height: 32)
                        Image(String(flag))
                            .resizable()
                            .scaledToFit()
                            .padding(4)
                    }
                    .border(Color.gray, width: 1)
                    .background(.white)
                }
                HStack() {
                }
                //HStack() {
                //}
                HStack {
                    Spacer()
                    Text(String("AP"))
                        .foregroundColor(.gray)
                        .font(.system(.headline))
                        .padding(4)
                        .frame(width: 32, height: 32)
                    Image(String("AP"))
                        .resizable()
                        .scaledToFit()
                        .padding(4)
                }
                .border(Color.gray, width: 1)
                .background(.white)
            }
            .padding(10) // Padding around the entire grid
            Spacer()
        }
    }
}

#Preview {
    FlagView()
}
