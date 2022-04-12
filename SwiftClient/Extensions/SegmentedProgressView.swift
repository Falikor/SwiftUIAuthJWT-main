//
//  SegmentedProgressView.swift
//  SwiftClient
//
//  Created by 19494115 on 25.03.2022.
//

import SwiftUI

struct SegmentedProgressView: View {
  var value: Int = 4
  var maximum: Int = 10
  var height: CGFloat = 20
  var spacing: CGFloat = 4
  var selectedColor: Color = .accentColor
  var unselectedColor: Color = Color.secondary.opacity(0.3)
var body: some View {
    HStack(spacing: spacing) {
        ForEach(0 ..< maximum) { index in
        Rectangle()
          .foregroundColor(index < self.value ? self.selectedColor : self.unselectedColor)
      }
    }
    .frame(maxHeight : height)
    .clipShape(Capsule())
  }
}
