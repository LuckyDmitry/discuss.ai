//
//  ContainerNextElementView.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 28.05.2023.
//

import Foundation
import SwiftUI
import Combine

struct ContainerNextElementView: View {
  var onFinish: EmptyAction?
  var views: [AnyIdentifiableView] = []
  
  @State
  private var index: Int = 0
  
  private var indexValue: CurrentValueSubject<Int, Never>
  
  init(_ makeViews: (@escaping EmptyAction) -> [any View], onFinish: EmptyAction?) {
    self.onFinish = onFinish
    let indexed = CurrentValueSubject<Int, Never>(0)
    self.views = makeViews {
      indexed.send(indexed.value + 1)
    }
    .map { AnyIdentifiableView($0) }
    indexValue = indexed
  }
  
  var body: some View {
    ZStack(alignment: .top) {
      ZStack {
        ForEach(views.viewEnumerated, id: \.index) { view in
          if view.index == self.index {
            view.element
              .transition(.push(from: .trailing))
          }
        }
      }
      HStack(spacing: 14) {
        ZStack {
          Circle()
            .fill(.white)
            .frame(width: 23, height: 23)
            .onTapGesture {
              withAnimation {
                indexValue.send(indexValue.value - 1)
              }
            }
          if index != 0 {
            Image(systemName: "chevron.left")
              .foregroundColor(Colors.TextAndIcons.gray2.color)
              .transition(.scale)
          }
        }
        
        ProgressView(
          value: CGFloat(index),
          total: CGFloat(views.count)
        )
        .tint(.white)
        .progressViewStyle(LinearProgressViewStyle())
        .frame(height: 8)
      }
    }
    .background(Colors.Background.main.color)
    .onReceive(indexValue) { newValue in
      withAnimation {
        index = newValue
      }
    }
  }
}
