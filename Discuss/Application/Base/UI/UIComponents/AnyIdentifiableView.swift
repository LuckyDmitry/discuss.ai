//
//  AnyIdentifiableView.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 28.05.2023.
//

import Foundation
import SwiftUI

struct AnyIdentifiableView: View, Identifiable {
  var id = UUID()
  
  var anyView: AnyView
  
  init<V: View>(_ view: V) {
    anyView = AnyView(view)
  }
  
  var body: some View {
    anyView
  }
}
