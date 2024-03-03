//
//  RollingCounterView.swift
//  Elizabeth
//
//  Created by Дмитрий Трифонов on 03/09/2023.
//

import SwiftUI

struct RollingCounterView: View {
  
  @Binding
  var value: Int
  
  @State
  private var animationRange: [Int] = []
  
  var textColor: Color
  var font: Font = .sfPro(.medium, size: 16)
  
  var body: some View {
    HStack(spacing: -4) {
      ForEach(0..<animationRange.count, id: \.self) { index in
        Text("8")
          .font(.system(size: 24))
          .bold()
          .opacity(0)
          .overlay {
            GeometryReader { reader in
              let size = reader.size
              VStack(spacing: 0) {
                ForEach(0...9, id: \.self) { number in
                  Text("\(number)")
                    .font(font)
                    .foregroundColor(textColor)
                    .frame(width: size.width, height: size.height, alignment: .center)
                }
              }
              .offset(y: -CGFloat(animationRange[index]) * size.height)
            }
          }
          .clipped()
      }
    }
    .onAppear {
      animationRange = Array(repeating: 0, count: "\(value)".count)
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.06) {
        updateAnimationRange()
      }
    }
    .onChange(of: value) { newValue in
      if "\(value)".count != "\(newValue)".count {
        animationRange = Array(repeating: 0, count: "\(newValue)".count)
      }
      value = newValue
      updateAnimationRange()
    }
  }
  
  private func updateAnimationRange() {
    let stringValue = "\(value)"
    
    for (index, val) in zip(0..<stringValue.count, stringValue) {
      
      let fractionValue = Double(index) * 0.15
      var fraction = fractionValue > 0.5 ? 0.5 : fractionValue
      
      withAnimation(.interactiveSpring(
        response: 0.8,
        dampingFraction: 1 + fraction,
        blendDuration: 1 + fraction
      )) {
        animationRange[index] = (String(val) as NSString).integerValue
      }
    }
  }
}

struct RollingCounterView_Previews: PreviewProvider {
  @State
  static var value = 123
  static var previews: some View {
    RollingCounterView(value: $value, textColor: .black)
      .onAppear {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
          value = 444
        }
      }
  }
}
