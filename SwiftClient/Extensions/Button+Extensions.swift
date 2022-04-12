//
//  Button+Extensions.swift
//  SwiftClient
//
//  Created by 19494115 on 20.03.2022.
//

import SwiftUI

struct WideOrangeButton: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(minWidth: 0,
                   maxWidth: .infinity)
            .foregroundColor(.white)
            .padding()
            .background( RoundedRectangle(cornerRadius: 5.0).fill(Color.orange)
        )
    }
}
