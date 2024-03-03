//
//  HapsticView.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 03.05.2023.
//

import Foundation
import SwiftUI

extension View {

  func hapticFeedbackOnTap(style: UIImpactFeedbackGenerator.FeedbackStyle = .light) -> some View {
    self.onTapGesture {
      let impact = UIImpactFeedbackGenerator(style: style)
      impact.impactOccurred()
    }
  }
}
