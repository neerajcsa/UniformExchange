//
//  Extension+String.swift
//  LoloAndBebo
//
//  Created by Neeraj Pandey on 21/01/19.
//  Copyright © 2019 Neeraj Pandey. All rights reserved.
//

import UIKit

extension String {
    func convertSpecialCharacter() -> String? {
        var convertedString : String?
        convertedString = self.trimmingCharacters(in: .whitespacesAndNewlines)
        convertedString = convertedString?.addingPercentEncoding(withAllowedCharacters: CharacterSet.init(charactersIn: Application.specialCharacter).inverted)
        return convertedString
    }
    
    func localizedString() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: "**\(self)**", comment: "")
    }
    
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
