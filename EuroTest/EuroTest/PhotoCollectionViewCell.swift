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
        let imgview = UIImageView(image: renderedImg)
        imgview.translatesAutoresizingMaskIntoConstraints = false
        imgview.roundUpCorners([.topRight, .topLeft], radius: 8)
        return imgview
    }()
    private var viewmodel: PhotoCellViewModel = PhotoCellViewModel()
    var sport, title, sub: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewmodel.layout(on: self, sport: sport, title: title, sub: sub)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
