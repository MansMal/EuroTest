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
        collection.delegate = self
        collection.backgroundColor = .darkGray
        return collection
    }()

    enum Section {
        case main
    }
    enum Constant {
        static var collectionSpacing: CGFloat = 16
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        bindData()
        self.view.backgroundColor = .placeholderText
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails",
            let destination = segue.destination as? DetailsViewController,
            let identifier = sender as? Int {
            let story = viewmodel.dataList.stories.filter({ return $0.id == identifier}).first
            destination.story = story
        }
    }
}
private extension ListViewController {
    func createLayout() -> UICollectionViewLayout {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = self.view.frame.width-32
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = Constant.collectionSpacing
        layout.minimumInteritemSpacing = Constant.collectionSpacing
        return layout
    }
    func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        view.addSubview(collectionView)
    }
    func bindData() {
        self.configureDataSource()
        Thread.runOnMain {
            self.snapshot.deleteAllItems()
            self.snapshot.appendSections([Section.main])
            self.snapshot.appendItems(self.viewmodel.collectionData)
            self.dataSource?.apply(self.snapshot, animatingDifferences: true)
        }
    }
    func configureDataSource() {
        dataSource = PhotoDataSource(collectionView: collectionView,
                                     cellProvider: { (collectionView, indexPath, model) -> PhotoCollectionViewCell? in
            let link = model.imageURL
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId,
                                                                for: indexPath) as? PhotoCollectionViewCell,
                    let url = URL(string: link) else {
                return PhotoCollectionViewCell()
            }
            Task(priority: .high) {
                cell.photoImage.image = try await ImageLoader().fetch(url)
            }
            return cell
        })
    }
}
extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = viewmodel.collectionData[indexPath.row]
        switch data.type {
        case .video:
            break
        default:
            performSegue(withIdentifier: "showDetails", sender: data.id)
        }
    }
}
