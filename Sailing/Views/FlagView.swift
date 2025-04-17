//
//  FlagView.swift
//  Sailing
//
//  Created by Gordon Aspin on 4/17/25.
//

import SwiftUI

struct FlagView: View {
    let flags = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
    let pennants = Array("0123456789")

    var body: some View {
        ScrollView {
            ForEach(flags, id: \.self) { flag in
                HStack {
                    Text(String(flag) + " ")
                        .foregroundColor(.black)
                        .font(.system(size: 48))
                    Image(String(flag))
                }
                .background(.white)
            }
            HStack {
                Text(String("AP"))
                    .foregroundColor(.black)
                    .font(.system(size: 48))
                Image(String("AP"))
            }
            .background(.white)
            ForEach(pennants, id: \.self) { pennant in
                HStack {
                    Text(String(pennant) + " ")
                        .foregroundColor(.black)
                        .font(.system(size: 48))
                    Image(String(pennant))
                }
                .background(.white)
            }
        }
        .background(.white)
    }
}

#Preview {
    FlagView()
}
