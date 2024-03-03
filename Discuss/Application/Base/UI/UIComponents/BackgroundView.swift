//
//  BackgroundView.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 26.03.2023.
//

import Foundation
import SwiftUI

struct BackgroundView<Content: View>: View {
    private var content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
      Color( UIColor.systemBackground)
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .overlay(content)
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
