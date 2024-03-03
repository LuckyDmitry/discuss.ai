import SwiftUI

struct ChatCongratulationsView: View {
  
  enum ColorSheme {
    case blue
    case green
    case purple
    
    var foregroundColor: Color {
      switch self {
      case .blue:
        return Asset.Colors.TxtIcons.Light.accent.swiftUIColor
      case .green:
        return Asset.Colors.Surfaces.Dark.green.swiftUIColor
      case .purple:
        return Asset.Colors.TxtIcons.Light.lilac.swiftUIColor
      }
    }
    
    var backgroundColor: Color {
      switch self {
      case .blue:
        return Asset.Colors.Surfaces.lightBlue.swiftUIColor
      case .green:
        return Asset.Colors.Surfaces.Dark.lightGreen.swiftUIColor
      case .purple:
        return Asset.Colors.Surfaces.Light.lilac.swiftUIColor
      }
    }
    
    var icon: Image {
      switch self {
      case .blue:
        return Asset.Chat.wordsCongratulations.swiftUIImage
      case .green:
        return Asset.Chat.starCongratulations.swiftUIImage
      case .purple:
        return Asset.Chat.lightCongratulations.swiftUIImage
      }
    }
  }
  
  var title: String
  var value: Int
  var colorSheme: ColorSheme
  
  var body: some View {
    VStack {
      Text(title)
        .font(.sfPro(.regular, size: 14))
        .foregroundColor(.white)
      HStack {
        colorSheme.icon
          .renderingMode(.template)
          .foregroundColor(.white)
          .frame(width: 16, height: 16)
          .padding(2)
          .background(
            Circle()
              .fill(colorSheme.foregroundColor)
          )
        RollingCounterView(value: .constant(value), textColor: colorSheme.foregroundColor)
      }
      .padding(.horizontal, 18)
      .padding(.vertical, 13)
      .frame(minWidth: 92)
      .background(
        RoundedRectangle(cornerRadius: 16)
          .fill(.white)
      )
    }
    .padding(EdgeInsets(top: 4, leading: 3, bottom: 3, trailing: 3))
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(colorSheme.backgroundColor)
    )
  }
}

struct ChatCongratulationsView_Previews: PreviewProvider {
  static var previews: some View {
    ChatCongratulationsView(
      title: "key phrases",
      value: 324,
      colorSheme: .purple
    )
  }
}
