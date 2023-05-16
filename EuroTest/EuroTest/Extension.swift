//
//  UIImageView+Extension.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import Foundation
import UIKit

extension Optional {
    func orValue(_ value: Wrapped) -> Wrapped {
        if let data = self {
            return data
        } else {
            return value
        }
    }
}
extension Double {
    func toDataString() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}

extension UINavigationController {
    
}

extension UIView {
    func roundUpCorners(_ corners: UIRectCorner, radius: CGFloat) {
        self.clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    @IBInspectable var masksToBounds: Bool {
        get {
            return self.layer.masksToBounds
        }
        
        set {
            self.layer.masksToBounds = newValue
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
extension UIColor {
    convenience init(hexString: String) {
        let hexString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexString as String)
        scanner.currentIndex = hexString.hasPrefix("#") ? hexString.startIndex : scanner.currentIndex
        
        var color: UInt64 = 0
        scanner.scanHexInt64(&color)
        
        let mask = 0x000000FF
        let redInt = Int(color >> 16) & mask
        let greenInt = Int(color >> 8) & mask
        let blueInt = Int(color) & mask
        
        let red   = CGFloat(redInt) / 255.0
        let green = CGFloat(greenInt) / 255.0
        let blue  = CGFloat(blueInt) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
}
extension String {
    public var convertHtmlToNSAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        do {
            return try NSAttributedString(data: data, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
