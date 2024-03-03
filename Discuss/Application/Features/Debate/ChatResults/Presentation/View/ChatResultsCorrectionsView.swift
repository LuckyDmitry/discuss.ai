//
//  ChatResultsCorrectionsView.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 04/11/2023.
//

import SwiftUI

struct ChatResultsCorrectionsView: View {
  struct SuggestItem: Identifiable, Hashable {
    var id: String {
      title
    }
    var title: String
    var description: String
  }
  
  var suggests: [SuggestItem]
  var mistakes: [SuggestItem]
  var motivationQuote: String
  
  @State
  var wrappedElement: SuggestItem?
  
  var body: some View {
    VStack(alignment: .leading) {
      list(title: "Mistakes", items: mistakes)
        .padding(.bottom, 16)
      list(title: "Vocabulary", items: suggests)
      Spacer()
    }
    .animation(.easeInOut, value: wrappedElement)
    .frame(maxWidth: .infinity, alignment: .topLeading)
  }
  
  @ViewBuilder
  private func list(title: String, items: [SuggestItem]) -> some View {
    if !items.isEmpty {
      Text(title)
        .font(.sfPro(.bold, size: 24))
        .padding(.horizontal, 16)
      ForEach(items, id: \.self) { mistake in
        VStack(alignment: .leading, spacing: 15) {
          HStack {
            Text(mistake.title)
            Spacer()
            Asset.Common.chevronDown.swiftUIImage
              .renderingMode(.template)
              .foregroundColor(.black)
              .rotationEffect(wrappedElement == mistake ? .zero : .degrees(-90))
          }
          if wrappedElement == mistake {
            Divider()
            Text(mistake.description)
              .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .top)).combined(with: .opacity))
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .background(
          Asset.Colors.Surfaces.Light.gray3.swiftUIColor
            .cornerRadius(20)
        )
        .padding(.vertical, 5)
        .padding(.horizontal, 16)
        .contentShape(Rectangle())
        .onTapGesture {
          if wrappedElement == mistake {
            wrappedElement = nil
          } else {
            wrappedElement = mistake
          }
        }
      }
    }
  }
}

struct ChatResultsCorrectionsView_Previews: PreviewProvider {
  static var previews: some View {
    ChatResultsCorrectionsView(
      suggests: [
        .init(title: "Title", description: "Hello"),
        .init(title: "Title2", description: "Hello"),
        .init(title: "Title3", description: "Hello"),
        .init(title: "Title4", description: "Hello")
      ],
      
      mistakes: [
        .init(title: "Title1", description: "Hello"),
        .init(title: "Title2", description: "Hello"),
        .init(title: "Title3", description: "Hello"),
        .init(title: "Title4", description: "Hello")
      ],
      motivationQuote: "You are next to me?"
    )
  }
}
