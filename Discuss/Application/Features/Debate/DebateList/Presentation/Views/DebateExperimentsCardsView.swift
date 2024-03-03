//
//  DebateExperimentsCardsView.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 23/11/2023.
//

import SwiftUI

struct DebateExperimentsCardsView: View {
  
  @Namespace
  var animation
  
  @State
  var isDetailShown = false
  
  
  var body: some View {
    VStack {
      Spacer()
      Button(action: {
        withAnimation {
          isDetailShown = true
        }
      }, label: {
        cardView()
          .border(.red)
      })
      .buttonStyle(ScaledButton())
      Spacer()
    }
    .frame(maxHeight: .infinity)
    .overlay {
      if isDetailShown {
        detailView()
          .onTapGesture {
            isDetailShown = false
          }
          .border(.green)
      }
    }
  }
  
  @ViewBuilder
  func cardView() -> some View {
    VStack(alignment: .leading, spacing: 15) {
      ZStack(alignment: .topLeading) {
        GeometryReader { reader in
          let size = reader.size
          
          Asset.cars.swiftUIImage
            .resizable()
            .frame(width: size.width, height: 400)
            .aspectRatio(contentMode: .fill)
          //            .frame(width: size.width, height: size.height)
//            .padding(40)
          
        }
        .frame(height: 400)
        
        LinearGradient(
          colors: [
            .black.opacity(0.5),
            .black.opacity(0.2),
            .clear
          ],
          startPoint: .top,
          endPoint: .bottom
        )
        VStack(alignment: .leading) {
          Text("Is abortion a murder?")
            .font(.largeTitle.bold())
            .foregroundColor(.white)
        }
        .padding()
      }
//      .clipped()
      .cornerRadius(20)
      HStack {
        Text("Is abortion a murder?")
      }
    }
//    .border(.blue)
    .matchedGeometryEffect(id: "item", in: animation)
  }

  @ViewBuilder
  func detailView() -> some View {
    ScrollView {
      VStack {
        cardView()
      }
    }
    .transition(.identity)
  }
}

struct DebateExperimentsDetailCardsView: View {
  
  @Namespace
  var name
  
  @Binding
  var isDetailShown: Bool
  
  var body: some View {
    RoundedRectangle(cornerRadius: 20)
      .fill(.orange)
      .onTapGesture {
        isDetailShown = false
      }
      .matchedGeometryEffect(id: "rect", in: name)
      .padding(.horizontal, 0)
      .padding(.bottom, 300)
  }
}

struct DebateExperimentsCardsView_Previews: PreviewProvider {
  static var previews: some View {
    DebateExperimentsCardsView()
      .padding()
  }
}

struct ScaledButton: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .scaleEffect(configuration.isPressed ? 0.94 : 1)
      .animation(.easeInOut, value: configuration.isPressed)
  }
}
