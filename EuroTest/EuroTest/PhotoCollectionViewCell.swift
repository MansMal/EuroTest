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
        imv.layer.cornerRadius = 12
        imv.layer.masksToBounds = true
        return imv
    }()
    private var viewmodel: PhotoCellViewModel = PhotoCellViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        viewmodel.layout(cell: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
