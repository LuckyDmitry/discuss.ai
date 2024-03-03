//
//  DetailedAnalyzeAnswerView.swift
//  Discuss.AI
//
//  Created by Дмитрий Трифонов on 03/11/2023.
//

import SwiftUI

struct DetailedAnalyzeAnswerView: View {
  
  let mistake: ExplanationDTO.SentenceMistakeDTO
  let onClose: () -> Void
  
  var body: some View {
    VStack(spacing: 0) {
      HStack {
        Text("Mistake")
          .font(.sfPro(.regular, size: 16))
        Spacer()
        Button(action: {
          onClose()
        }, label: {
          Asset.Common.close.swiftUIImage
            .resizable()
            .frame(width: 16, height: 16)
        })
      }
      .padding(.top, 24)
      .padding(.bottom, 44)
      HStack {
        VStack(alignment: .leading) {
          Text(mistake.mistake)
            .font(.sfPro(.bold, size: 16))
          Text(mistake.corrected)
            .font(.sfPro(.regular, size: 16))
        }
      }
      .padding(.horizontal, 18)
      .padding(.vertical, 16)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(Asset.Colors.Surfaces.Light.gray3.swiftUIColor.cornerRadius(20))
      .padding(.bottom, 12)
      Text(mistake.explanation)
        .font(.sfPro(.regular, size: 16))
      Spacer()
      PrimaryButton(action: {
        onClose()
      }, text: "Okay", colorSheme: .gray)
    }
    .padding(.vertical)
    .padding(.horizontal, 24)
  }
}

struct DetailedAnalyzeAnswerView_Previews: PreviewProvider {
    static var previews: some View {
      DetailedAnalyzeAnswerView(mistake: .init(mistake: "Baby don't hurt my!", corrected: "Baby don't hurt me!", explanation: "“Baby don’t hurt me” is a phrase that means “please don’t hurt me” or “please don’t cause me emotional pain”. It can be used in varios context, such as in a plea to a romantic partner to treat the speaker kindly or in relation to any situation where the speaker feels vulnerable and is asking for protection or care. The phrase gained fame throught the 1993 song “What is Love” by Haddaway. "), onClose: {})
    }
}
