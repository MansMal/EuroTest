//
//  UIImageView+Extension.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import Foundation

extension Optional {
    func orValue(_ value: Wrapped) -> Wrapped {
        if let data = self {
            return data
        } else {
            return value
        }
    }
}
