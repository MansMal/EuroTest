//
//  ViewController.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import UIKit

private typealias PhotoDataSource  = UICollectionViewDiffableDataSource<ListViewController.Section, CollectionItem>
private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<ListViewController.Section, CollectionItem>

final class ListViewController: UIViewController {
        
    let viewmodel: ListViewModel = ListViewModel()
    private let cellId = "cell"
    private lazy var snapshot = DataSourceSnapshot()
    private var dataSource: PhotoDataSource?
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .clear
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    enum Section {
        case main
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails",
            let destination = segue.destination as? DetailsViewController {
            
        }
    }
}
extension ListViewController {
    func createLayout() -> UICollectionViewLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = self.view.frame.width/2-32
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        return layout
    }
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView)
    }
}
