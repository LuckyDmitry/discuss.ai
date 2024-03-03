//
//  String+Extension.swift
//  TikTok
//
//  Created by Trifonov Dmitriy Aleksandrovich on 26.02.2023.
//  Copyright © 2023 Osaretin Uyigue. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func split(_ sep: String = " ") -> [String] {
        self.components(separatedBy: sep)
    }
}

extension String {
    var firstCapitalized: String {
        return prefix(1).capitalized + dropFirst()
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
