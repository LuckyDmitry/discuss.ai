//
//  Fonts.swift
//  Elizabeth
//
//  Created by Trifonov Dmitriy Aleksandrovich on 06.05.2023.
//

import Foundation
import SwiftUI

enum SFProFonts: String, RawRepresentable {
  case regular = "SFPro-Regular"
  case ultralight = "SFPro-Ultralight"
  case thin = "SFPro-Thin"
  case light = "SFPro-Light"
  case medium = "SFPro-Medium"
  case semibold = "SFPro-Semibold"
  case bold = "SFPro-Bold"
  case heavy = "SFPro-Heavy"
  case black = "SFPro-Black"
  case condensedRegular = "SFPro-CondensedRegular"
  case condensedUltralight = "SFPro-CondensedUltralight"
  case condensedThin = "SFPro-CondensedThin"
  case condensedLight = "SFPro-CondensedLight"
  case condensedMedium = "SFPro-CondensedMedium"
  case condensedSemibold = "SFPro-CondensedSemibold"
  case condensedBold = "SFPro-CondensedBold"
  case condensedHeavy = "SFPro-CondensedHeavy"
  case condensedBlack = "SFPro-CondensedBlack"
  case expandedRegular = "SFPro-ExpandedRegular"
  case expandedUltralight = "SFPro-ExpandedUltralight"
  case expandedThin = "SFPro-ExpandedThin"
  case expandedLight = "SFPro-ExpandedLight"
  case expandedMedium = "SFPro-ExpandedMedium"
  case expandedSemibold = "SFPro-ExpandedSemibold"
  case expandedBold = "SFPro-ExpandedBold"
  case expandedHeavy = "SFPro-ExpandedHeavy"
  case expandedBlack = "SFPro-ExpandedBlack"
  case compressedRegular = "SFPro-CompressedRegular"
  case compressedUltralight = "SFPro-CompressedUltralight"
  case compressedThin = "SFPro-CompressedThin"
  case compressedLight = "SFPro-CompressedLight"
  case compressedMedium = "SFPro-CompressedMedium"
  case compressedSemibold = "SFPro-CompressedSemibold"
  case compressedBold = "SFPro-CompressedBold"
  case compressedHeavy = "SFPro-CompressedHeavy"
  case compressedBlack = "SFPro-CompressedBlack"
}

extension Font {
  static func sfPro(_ name: SFProFonts, size: CGFloat) -> Font {
    Font.custom(name.rawValue, size: size)
  }
}
