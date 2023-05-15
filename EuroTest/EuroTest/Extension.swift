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
