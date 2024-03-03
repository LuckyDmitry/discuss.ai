// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Asset {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal enum Auth {
    internal static let googleLogo = ImageAsset(name: "google_logo")
  }
  internal enum Chat {
    internal static let apple = ImageAsset(name: "apple")
    internal static let arrowUp = ImageAsset(name: "arrow_up")
    internal static let bookmark = ImageAsset(name: "bookmark")
    internal static let business = ImageAsset(name: "business")
    internal static let correct = ImageAsset(name: "correct")
    internal static let drum = ImageAsset(name: "drum")
    internal static let earpods = ImageAsset(name: "earpods")
    internal static let error = ImageAsset(name: "error")
    internal static let filledStar = ImageAsset(name: "filled_star")
    internal static let heart = ImageAsset(name: "heart")
    internal static let info = ImageAsset(name: "info")
    internal static let lightCongratulations = ImageAsset(name: "light_congratulations")
    internal static let lighting = ImageAsset(name: "lighting")
    internal static let messageRetry = ImageAsset(name: "message_retry")
    internal static let messageTranslate = ImageAsset(name: "message_translate")
    internal static let mistake = ImageAsset(name: "mistake")
    internal static let pause = ImageAsset(name: "pause")
    internal static let player = ImageAsset(name: "player")
    internal static let star = ImageAsset(name: "star")
    internal static let starCongratulations = ImageAsset(name: "star_congratulations")
    internal static let sun = ImageAsset(name: "sun")
    internal static let translate = ImageAsset(name: "translate")
    internal static let voice = ImageAsset(name: "voice")
    internal static let wordsCongratulations = ImageAsset(name: "words_congratulations")
  }
  internal enum Colors {
    internal enum Surfaces {
      internal static let blue = ColorAsset(name: "Colors/Surfaces/Blue")
      internal enum Dark {
        internal static let gray2 = ColorAsset(name: "Colors/Surfaces/Dark/Gray2")
        internal static let gray3 = ColorAsset(name: "Colors/Surfaces/Dark/Gray3")
        internal static let green = ColorAsset(name: "Colors/Surfaces/Dark/Green")
        internal static let lightGreen = ColorAsset(name: "Colors/Surfaces/Dark/LightGreen")
        internal static let mint = ColorAsset(name: "Colors/Surfaces/Dark/Mint")
      }
      internal static let gray2 = ColorAsset(name: "Colors/Surfaces/Gray2")
      internal static let gray3 = ColorAsset(name: "Colors/Surfaces/Gray3")
      internal enum Light {
        internal static let gray2 = ColorAsset(name: "Colors/Surfaces/Light/Gray2")
        internal static let gray3 = ColorAsset(name: "Colors/Surfaces/Light/Gray3")
        internal static let lightBlue = ColorAsset(name: "Colors/Surfaces/Light/LightBlue")
        internal static let lilac = ColorAsset(name: "Colors/Surfaces/Light/Lilac")
      }
      internal static let lightBlue = ColorAsset(name: "Colors/Surfaces/LightBlue")
      internal static let ultraLightBlue = ColorAsset(name: "Colors/Surfaces/UltraLightBlue")
    }
    internal enum TxtIcons {
      internal static let gray = ColorAsset(name: "Colors/TxtIcons/Gray")
      internal static let gray2 = ColorAsset(name: "Colors/TxtIcons/Gray2")
      internal enum Light {
        internal static let accent = ColorAsset(name: "Colors/TxtIcons/Light/Accent")
        internal static let gray1 = ColorAsset(name: "Colors/TxtIcons/Light/Gray1")
        internal static let gray2 = ColorAsset(name: "Colors/TxtIcons/Light/Gray2")
        internal static let lilac = ColorAsset(name: "Colors/TxtIcons/Light/Lilac")
      }
      internal static let red = ColorAsset(name: "Colors/TxtIcons/Red")
    }
  }
  internal enum Common {
    internal static let backArrow = ImageAsset(name: "back_arrow")
    internal static let backChevron = ImageAsset(name: "back_chevron")
    internal static let chevron = ImageAsset(name: "chevron")
    internal static let chevronDown = ImageAsset(name: "chevron_down")
    internal static let close = ImageAsset(name: "close")
    internal static let toolError = ImageAsset(name: "tool_error")
  }
  internal enum Home {
    internal static let filter = ImageAsset(name: "filter")
  }
  internal enum Onboarding {
    internal static let barrier = ImageAsset(name: "barrier")
    internal static let canSpeak = ImageAsset(name: "canSpeak")
    internal static let fluent = ImageAsset(name: "fluent")
    internal static let justStarting = ImageAsset(name: "justStarting")
    internal static let lessMistakes = ImageAsset(name: "lessMistakes")
    internal static let newWords = ImageAsset(name: "newWords")
    internal static let pronunciation = ImageAsset(name: "pronunciation")
    internal static let speakConfidently = ImageAsset(name: "speakConfidently")
    internal static let specificSituation = ImageAsset(name: "specificSituation")
  }
  internal enum Profile {
    internal static let book = ImageAsset(name: "book")
    internal static let checkCircle = ImageAsset(name: "check_circle")
    internal static let clock = ImageAsset(name: "clock")
    internal static let favorite = ImageAsset(name: "favorite")
    internal static let fire = ImageAsset(name: "fire")
    internal static let missed = ImageAsset(name: "missed")
    internal static let settings = ImageAsset(name: "settings")
    internal static let star = ImageAsset(name: "star")
    internal static let world = ImageAsset(name: "world")
  }
  internal enum TabBar {
    internal static let chat = ImageAsset(name: "chat")
    internal static let main = ImageAsset(name: "main")
    internal static let menu = ImageAsset(name: "menu")
    internal static let profile = ImageAsset(name: "profile")
  }
  internal enum Video {
    internal static let videoHeart = ImageAsset(name: "video_heart")
    internal static let videoSubtitles = ImageAsset(name: "video_subtitles")
  }
  internal static let cars = ImageAsset(name: "cars")
  internal static let image = ImageAsset(name: "image")
  internal static let translation = ImageAsset(name: "translation")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal private(set) lazy var swiftUIColor: SwiftUI.Color = {
    SwiftUI.Color(asset: self)
  }()
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Color {
  init(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }
}
#endif

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
  internal var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, *)
internal extension SwiftUI.Image {
  init(asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle)
  }

  init(asset: ImageAsset, label: Text) {
    let bundle = BundleToken.bundle
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: ImageAsset) {
    let bundle = BundleToken.bundle
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
