import SwiftUI

struct TinderCardView: View {
  
  // MARK: State
  
  @State
  private var cardOffset: CGFloat = 0

  @State
  private var dragTranslation: CGFloat = 0
  
  @State
  private var cardDragTranslation: CGSize = .zero
  
  @State
  private var titleSize: CGSize?
  
  @State
  private var subtitleSize: CGSize?
  
  @State
  private var viewSize: CGSize = .zero
  
  // MARK: Internal
  
  var question: DebateQuestion
  var onCloseTap: () -> Void
  var onCardTap: () -> Void
  var onVocaularyTap: () -> Void
  var cardIndex: Int
  
  @Binding
  var isDetailShown: Bool
  
  // MARK: Gestures
  
  private var detailHideGesture: _EndedGesture<_ChangedGesture<DragGesture>> {
    DragGesture(minimumDistance: 1, coordinateSpace: .local)
      .onChanged { proxy in
        withAnimation(.discussInteractiveSring) {
          if proxy.translation.height < 0 {
            dragTranslation = 0
          } else {
            let translation = abs(proxy.translation.height)
            dragTranslation = min(10, translation) + translation * 0.02
          }
        }
      }
      .onEnded {
        let translation = $0.translation.height
        withAnimation(.discussInteractiveSring) {
          if translation > 100 {
            AnalyticsService.event(.swipeBackCard(question.topic.title))
            isDetailShown = false
          } else {
            isDetailShown = true
          }
          dragTranslation = 0
        }
      }
  }
  
  private var skipCardGesture: _EndedGesture<_ChangedGesture<DragGesture>> {
    DragGesture(minimumDistance: 1, coordinateSpace: .local)
      .onChanged { proxy in
        withAnimation(.discussInteractiveSring) {
          cardDragTranslation = .init(width: proxy.translation.width, height: proxy.translation.height)
          
        }
      }.onEnded({ proxy in
        withAnimation(.discussInteractiveSring) {
          let resultTranslation: CGSize = .init(width: cardDragTranslation.width * 2.5, height: cardDragTranslation.height * 2.5)
          if viewSize.width / 3 < abs(proxy.translation.width) || viewSize.height / 3 < abs(proxy.translation.height) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(150)) {
              onCloseTap()
            }
            cardDragTranslation = resultTranslation
          } else {
            cardDragTranslation = .zero
          }
        }
      })
  }
  
  // MARK: Body
  
  var body: some View {
    GeometryReader { reader in
      let height: CGFloat = cardIndex < 3 && !isDetailShown ? reader.size.height - CGFloat(10 * cardIndex + 1) : reader.size.height
      let offset: CGFloat = reader.size.height - height
      ZStack(alignment: .top) {
        if isDetailShown {
          detailCloseView
        }
        VStack(spacing: 0) {
          imageView
          titleView
//          subtitleView
          Spacer()
          if isDetailShown {
            vocabularyView
          }
        }
        .opacity(1.0 - (abs(cardDragTranslation.width) / 500.0) + (abs(cardDragTranslation.height) / 500.0))
        
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .overlay {
        ZStack {
          Color.black
            .cornerRadius(20)
          skipView
        }
        .opacity(min(0.0 + (abs(cardDragTranslation.width) / 400.0) + (abs(cardDragTranslation.height) / 400.0), 0.5))
      }
      .background(
        ZStack {
          RoundedRectangle(cornerRadius: 20)
            .fill(Asset.Colors.Surfaces.Light.gray2.swiftUIColor)
          RoundedRectangle(cornerRadius: 20)
            .cardGradient(color: Color(hex: question.color))
            .padding(1)
        }
          .frame(height: height)
      )
      .scaleEffect(scaleEffectOnTraslationValue)
      .offset(y: cardOffset + dragTranslation - offset)
      .offset(cardDragTranslation)
    }
    .readSize(onChange: { viewSize = $0 })
    .gesture(
      isDetailShown ?
      detailHideGesture :
      skipCardGesture
    )
    .onTapGesture {
      onCardTap()
      isDetailShown = true
    }
    .opacity(!isDetailShown && cardIndex >= 3 ? 0 : 1)
    .animation(.default, value: cardIndex)
  }
  
  private var scaleEffectOnTraslationValue: CGFloat {
    1.0 - dragTranslation * 0.01
  }
  
  private var detailCloseView: some View {
    Button(action: {
      AnalyticsService.event(.tapOnCloseDetailCard(self.question.topic.title))
      isDetailShown = false
    }, label: {
      Asset.Common.backChevron.swiftUIImage
        .foregroundColor(.black)
        .frame(width: 20, height: 20)
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 12).fill(Asset.Colors.Surfaces.Light.gray3.swiftUIColor))
        .padding(.leading, 24)
        .padding(.top, 40)
    })
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    .opacity(1 - dragTranslation * 0.05)
  }
  
  private var imageView: some View {
    FirebaseImage(
      name: question.image,
      color: question.color
    )
    .frame(width: isDetailShown ? 120 : 240, height: isDetailShown ? 120 : 240)
    .padding(.top, 56)
    .padding(.bottom, 36)
    .cornerRadius(15)
  }
  
  private var titleView: some View {
    Text(question.title)
      .multilineTextAlignment(.center)
      .minimumScaleFactor(0.4)
      .fixedSize(horizontal: false, vertical: true)
      .font(.sfPro(.bold, size: 24))
      .padding(.bottom, 4)
      .padding(.horizontal)
      .frame(width: titleSize?.width, height: titleSize?.height)
      .readSize {
        if titleSize == nil && $0.width != 0 && $0.height != 0 {
          titleSize = $0
        }
      }
  }
  
  private var vocabularyView: some View {
    Button(action: {
      onVocaularyTap()
    }, label: {
      Text("Vocabulary")
        .font(.sfPro(.medium, size: 20))
        .multilineTextAlignment(.center)
        .padding(.vertical, 16)
        .padding(.horizontal, 32)
        .background(
          RoundedRectangle(cornerRadius: 20)
            .fill(.white)
        )
        
    })
    .buttonStyle(.plain)
    .padding(.bottom, 32)
  }
  
  private var subtitleView: some View {
    Text(question.description)
      .font(.sfPro(.regular, size: 14))
      .multilineTextAlignment(.center)
      .padding(.bottom, 38)
      .padding(.horizontal, 20)
      .frame(width: subtitleSize?.width, height: subtitleSize?.height)
      .readSize {
        if subtitleSize == nil && $0.width != 0 && $0.height != 0 {
          subtitleSize = $0
        }
      }
      .opacity(isDetailShown ? 1 : 0)
  }

  private var skipView: some View {
    Text("Skip")
      .font(.sfPro(.semibold, size: 56))
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(
        RoundedRectangle(cornerRadius: 20)
          .fill(.white)
      )
  }
}

struct TinderCardView_Previews: PreviewProvider {
  
  @State
  static var isDetailShown = true
  
  static var previews: some View {
    TinderCardView(
      question: DebateQuestion.random(),
      onCloseTap: {},
      onCardTap: {},
      onVocaularyTap: {},
      cardIndex: 0,
      isDetailShown: $isDetailShown
    )
    .padding(.vertical, 120)
    .padding(.horizontal, 10)
  }
}

private enum ViewIdentifier: String {
  case card
  case title
  case subtitle
}
