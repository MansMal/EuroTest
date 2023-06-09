//
//  PhotoCellViewModel.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import Foundation
import UIKit

final class PhotoCellViewModel: ObservableObject {

    var item: CollectionItem!
    
    func layout(on cell: PhotoCollectionViewCell, item: CollectionItem) {
        guard cell.contentView.subviews.count == 0 else { return }
        cell.layer.cornerRadius = 8
        cell.contentView.addSubview(cell.photoImage)
        NSLayoutConstraint.activate([
            cell.photoImage.topAnchor.constraint(equalTo: cell.topAnchor),
            cell.photoImage.leadingAnchor.constraint(equalTo: cell.leadingAnchor),
            cell.photoImage.widthAnchor.constraint(equalTo: cell.widthAnchor),
            cell.photoImage.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -116)
        ])
        _ = item.type == .video ? self.addPlayerIcon(on: cell.photoImage) : ()
        cell.backgroundColor = .white
        let sportView = self.sportView(with: item.desc)
        sportView.translatesAutoresizingMaskIntoConstraints = false
        sportView.layer.cornerRadius = 6
        cell.contentView.addSubview(sportView)
        NSLayoutConstraint.activate([
            sportView.widthAnchor.constraint(equalToConstant: 120),
            sportView.heightAnchor.constraint(equalToConstant: 26),
            sportView.bottomAnchor.constraint(equalTo: cell.photoImage.bottomAnchor, constant: 13),
            sportView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16)
        ])
        let infoview = self.infoView(text: item.title, sub: item.subTitle)
        infoview.translatesAutoresizingMaskIntoConstraints = false
        cell.contentView.addSubview(infoview)
        NSLayoutConstraint.activate([
            infoview.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor),
            infoview.heightAnchor.constraint(equalToConstant: 116),
            infoview.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor, constant: 16),
            infoview.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor, constant: -16)
        ])
    }
}
private extension PhotoCellViewModel {
    func addPlayerIcon(on view: UIView) {
        let imageview = UIImageView(image: UIImage(named: "play"))
        imageview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageview)
        NSLayoutConstraint.activate([
            imageview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageview.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageview.widthAnchor.constraint(equalToConstant: 60),
            imageview.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    func infoView(text: String, sub: String) -> UIView {
        let titleView = UIView()
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 20)
        label.text = text
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            label.topAnchor.constraint(equalTo: titleView.topAnchor),
            label.centerXAnchor.constraint(equalTo: titleView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])
        
        let descLabel = UILabel()
        descLabel.textColor = .gray
        descLabel.text = sub
        descLabel.textAlignment = .left
        descLabel.numberOfLines = 0
        descLabel.font = .systemFont(ofSize: 10)
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        titleView.addSubview(descLabel)
        NSLayoutConstraint.activate([
            descLabel.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            descLabel.bottomAnchor.constraint(equalTo: titleView.bottomAnchor, constant: -6),
            descLabel.centerXAnchor.constraint(equalTo: titleView.centerXAnchor)
        ])
        return titleView
    }
    func sportView(with text: String) -> UIView {
        let sportView = UIView()
        sportView.backgroundColor = UIColor(hexString: "151b4a")
        let label = UILabel()
        label.textColor = .white
        label.text = text
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        sportView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: sportView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: sportView.centerYAnchor)
        ])

        return sportView
    }
}
