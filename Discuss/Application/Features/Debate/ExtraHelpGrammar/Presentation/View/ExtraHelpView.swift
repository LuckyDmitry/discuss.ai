//
//  ExtraGrammarView.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 12/11/2023.
//

import SwiftUI
import ActivityIndicatorView

struct ExtraHelpView: View {
  
  @StateObject
  var viewContext: ViewContext<ExtraHelpState, ExtraHelpAction>
  
  var body: some View {
    VStack {
      ZStack(alignment: .bottom) {
        ScrollView(showsIndicators: false) {
          Text("Extra")
            .font(.sfPro(.bold, size: 24))
            .padding(.top, 32)
          Text("Familiarise yourself with the grammar and basic phrases on the topic")
            .font(.sfPro(.medium, size: 20))
            .multilineTextAlignment(.center)
            .padding(.top, 16)
          section(title: "Vocabulary", contents: viewContext.vocabulary)
        }
        .padding(.bottom, 84)
        PrimaryButton(action: {
          viewContext.handle(.tapOnClose)
        }, text: "Okay", colorSheme: .black)
      }
    }
    .padding(.horizontal)
    .onAppear {
      viewContext.handle(.viewAppeared)
    }
  }
  
  private func section(
    title: String,
    contents: [ExtraHelpState.Content]
  ) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(title)
        .font(.sfPro(.bold, size: 20))
        .foregroundColor(Asset.Colors.TxtIcons.Light.gray1.swiftUIColor)
        .padding(.bottom)
      
      ForEach(contents, id: \.original.word) { content in
        HStack {
          VStack(alignment: .leading) {
            switch content.translation {
            case .idle, .loading:
              Text(content.original.word)
                .font(.sfPro(.bold, size: 16))
                .foregroundColor(Asset.Colors.TxtIcons.Light.gray1.swiftUIColor)
                .padding(.bottom, 4)
              Text(content.original.meaning)
                .font(.sfPro(.regular, size: 16))
                .foregroundColor(Asset.Colors.TxtIcons.Light.gray2.swiftUIColor)
            case let .loaded(loaded):
              Text(loaded.word)
                .font(.sfPro(.bold, size: 16))
                .foregroundColor(Asset.Colors.TxtIcons.Light.gray1.swiftUIColor)
                .padding(.bottom, 4)
              Text(loaded.meaning)
                .font(.sfPro(.regular, size: 16))
                .foregroundColor(Asset.Colors.TxtIcons.Light.gray2.swiftUIColor)
            }
          }
          Spacer()
          if content.translation.isLoading {
            ProgressView()
              .frame(width: 30, height: 30)
          } else {
            Button(action: {
              viewContext.handle(.tapOnTranslation(content))
            }, label: {
              Asset.translation.swiftUIImage
                .resizable()
                .frame(width: 30, height: 30)
            })
          }
        }
        .padding(16)
        .frame(maxWidth: .infinity)
        .background(
          RoundedRectangle(cornerRadius: 20)
            .fill(Asset.Colors.Surfaces.Light.gray3.swiftUIColor)
        )
      }
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .padding(.top, 52)
  }
}

struct ExtraHelpView_Previews: PreviewProvider {
  static var previews: some View {
    ExtraHelpView(viewContext:
      .preview(.init(
      vocabulary: [
        .init(original: .init(word: "21", meaning: "12"))
        ]
    )))
  }
}
