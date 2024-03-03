//
//  DebateDetailsView.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 27/11/2023.
//

import SwiftUI

struct DebateDetailsView: View {
  
  var question: DebateQuestion
  var onStartDebate: (Bool) -> Void
  
  var body: some View {
    VStack {
      ZStack(alignment: .bottom) {
        ScrollView {
//          AsyncImage(url: question.image)
//            .frame(width: 200, height: 200)
//            .cornerRadius(100)
          Text(question.title)
            .font(.sfPro(.bold, size: 28))
            .padding(.top, 50)
          Text(question.description)
            .font(.sfPro(.regular, size: 20))
            .multilineTextAlignment(.center)
            .padding(.top, 5)
          
          VStack(alignment: .leading) {
            Text("Vocabulary")
            ForEach(question.vocabulary, id: \.word) { vocabulary in
              cardView(vocabulary.word, subtitle: vocabulary.meaning)
            }
          }
          .padding(.top, 50)
          .padding(.horizontal, 20)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding(.bottom, 100)
        }
        HStack {
          PrimaryButton(action: {
            onStartDebate(false)
//            viewContext.handle(.tapOnStartBattle(against: false))
          }, text: "Support", colorSheme: .black)
          PrimaryButton(action: {
            onStartDebate(true)
//            viewContext.handle(.tapOnStartBattle(against: true))
          }, text: "Opposite", colorSheme: .black)
        }
        .padding(.horizontal, 20)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color(red: 243 / 255, green: 243 / 255, blue: 243 / 255))
  }
  
  private func cardView(_ title: String, subtitle: String?) -> some View {
    HStack {
      VStack(alignment: .leading, spacing: 8) {
        Text(title)
          .font(.sfPro(.bold, size: 16))
        if let subtitle {
          Text(subtitle)
            .font(.sfPro(.regular, size: 14))
            .foregroundColor(.black.opacity(0.6))
        }
      }
      Spacer()
      Button(action: {
        
      }, label: {
        Asset.Chat.translate.swiftUIImage
          .resizable()
          .frame(width: 30, height: 30)
        
      })
    }
    .padding(15)
    .padding(.horizontal, 5)
    .frame(maxWidth: .infinity, alignment: .leading)
    .background {
      RoundedRectangle(cornerRadius: 20)
        .fill(.white)
    }
  }
}

struct DebateDetailsView_Previews: PreviewProvider {
  static var previews: some View {
    DebateDetailsView(question: .init(
      questionId: "12312",
      title: "Are video games harmful?",
      description: "They are evidence that video games are harmful",
      topic: .environment,
      level: .beginner,
      image: "dasdsa",
      vocabulary: [
        .init(word: "Video games", meaning: "Video games"),
        .init(word: "Harmful", meaning: "Bringing harm"),
        .init(word: "Harmful1", meaning: "Bringing harm"),
        .init(word: "Harmful2", meaning: "Bringing harm"),
        .init(word: "Harmful3", meaning: "Bringing harm"),
        .init(word: "Harmful5", meaning: "Bringing harm"),
        .init(word: "Harmful6", meaning: "Bringing harm"),
      
      ],
      color: "#FF0000"
    ), onStartDebate: { _ in })
  }
}
