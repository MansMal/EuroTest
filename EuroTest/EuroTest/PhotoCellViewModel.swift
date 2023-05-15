//
//  PhotoCellViewModel.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import Foundation
import UIKit

final class PhotoCellViewModel {
 
    func layout(cell: PhotoCollectionViewCell) {
        cell.backgroundView = UIView()
        cell.backgroundView?.addSubview(cell.photoImage)
        NSLayoutConstraint.activate([
            cell.photoImage.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
            cell.photoImage.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            cell.photoImage.widthAnchor.constraint(equalTo: cell.widthAnchor),
            cell.photoImage.heightAnchor.constraint(equalTo: cell.heightAnchor)
        ])
    }

}
