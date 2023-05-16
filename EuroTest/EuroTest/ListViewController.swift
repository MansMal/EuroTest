//
//  ViewController.swift
//  EuroTest
//
//  Created by Malek Mansour on 15/05/2023.
//

import UIKit
import AVKit

private typealias PhotoDataSource  = UICollectionViewDiffableDataSource<ListViewController.Section, CollectionItem>
private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<ListViewController.Section, CollectionItem>

final class ListViewController: UIViewController {
        
    private let viewmodel: ListViewModel = ListViewModel()
    private let cellId = "cell"
    private lazy var snapshot = DataSourceSnapshot()
    private var dataSource: PhotoDataSource?
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: self.createLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
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
        self.view.backgroundColor = UIColor(hexString: "f2f2f2")
        self.confNavBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails",
            let destination = segue.destination as? DetailsViewController,
            let identifier = sender as? Int {
            let story = viewmodel.dataList?.stories.filter({ return $0.id == identifier}).first
            destination.story = story
        }
    }
}
// MARK: is about dataSource
private extension ListViewController {
    func bindData() {
        guard let data = self.viewmodel.collectionData else { return }
        self.configureDataSource()
        Thread.runOnMain {
            self.snapshot.deleteAllItems()
            self.snapshot.appendSections([Section.main])
            self.snapshot.appendItems(data)
            self.dataSource?.apply(self.snapshot, animatingDifferences: true)
        }
    }
    func configureDataSource() {
        dataSource = PhotoDataSource(collectionView: collectionView,
                                     cellProvider: { (collectionView, indexPath, model) -> PhotoCollectionViewCell? in
            let link = model.imageURL
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: self.cellId, for: indexPath
            ) as? PhotoCollectionViewCell, let url = URL(string: link) else {
                return PhotoCollectionViewCell()
            }
            
            Thread.runOnMain {
                Task(priority: .high) {
                    cell.photoImage.image = try await ImageLoader().fetch(url)
                    cell.title = model.title
                    cell.sport = model.desc
                    cell.sub = model.subTitle
                }
                _ = model.type == .video ? self.addPlayerIcon(on: cell.contentView) : ()
            }
            return cell
        })
    }
}

// MARK: is about UI
private extension ListViewController {
    func confNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(hexString: "151b4a")
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        let titleView = self.navBartitleView()
        navigationController?.navigationBar.topItem?.titleView = titleView
    }
    func navBartitleView() -> UIView {
        let titleLabel = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 200, height: 60)))
        titleLabel.text = "FEATURED"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }
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
        collectionView.backgroundColor = UIColor(hexString: "f2f2f2")
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    func addPlayerIcon(on view: UIView) {
        let imageview = UIImageView(image: UIImage(named: "play"))
        view.addSubview(imageview)
//        NSLayoutConstraint.activate([
//            imageview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            imageview.topAnchor.constraint(equalTo: view.topAnchor, constant: 36)
//        ])
    }
}

extension ListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = viewmodel.collectionData?[indexPath.row] else { return }
        switch data.type {
        case .video:
            readView(from: data.videoUrl)
        default:
            performSegue(withIdentifier: "showDetails", sender: data.id)
        }
    }
    private func readView(from url: String) {
        let videoURL = URL(string: url)
        let player = AVPlayer(url: videoURL! as URL)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        Thread.runOnMain {
            self.present(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
        }
    }
}
