//
//  PhotoCollectionViewCell.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import Foundation
import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {

    lazy var photoImage: UIImageView = {
        let profileImg = UIImage(systemName: "person.crop.circle")
        let renderedImg = profileImg!.withTintColor(.gray, renderingMode: .alwaysOriginal)
        let imv = UIImageView(image: renderedImg )
        imv.translatesAutoresizingMaskIntoConstraints = false
        imv.layer.cornerRadius = 25
        imv.layer.masksToBounds = true
        return imv
    }()
}
