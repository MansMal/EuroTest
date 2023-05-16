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
    var viewmodel: PhotoCellViewModel = PhotoCellViewModel()
    var sport, title, sub: String?

    func layout(with url: URL, and item: CollectionItem) {
        Task(priority: .high) {
            photoImage.image = try await ImageLoader().fetch(url)
        }
        viewmodel.layout(on: self, item: item)
    }
}
