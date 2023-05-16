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
        let backgroundView = UIView()
        backgroundView.backgroundColor = .white
        cell.backgroundView = backgroundView
        cell.backgroundView?.addSubview(cell.photoImage)
        NSLayoutConstraint.activate([
            cell.photoImage.topAnchor.constraint(equalTo: cell.topAnchor),
            cell.photoImage.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            cell.photoImage.widthAnchor.constraint(equalTo: cell.widthAnchor),
            cell.photoImage.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -116)
        ])
    }
    
}
