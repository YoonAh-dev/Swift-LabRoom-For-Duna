//
//  ViewController.swift
//  CollectionView-SwipeAction
//
//  Created by SHIN YOON AH on 2022/01/02.
//

import UIKit

final class ViewController: UIViewController {
    
    private enum Section: CaseIterable {
        case emoji
    }
    
    private var animals = [Animal(image: "🐶", name: "Dog"),
                           Animal(image: "🐱", name: "Cat"),
                           Animal(image: "🐭", name: "Mouse"),
                           Animal(image: "🐹", name: "Hamster"),
                           Animal(image: "🐮", name: "Cow"),
                           Animal(image: "🐰", name: "Rabbit"),
                           Animal(image: "🦊", name: "Fox"),
                           Animal(image: "🐻", name: "Bear"),
                           Animal(image: "🐼", name: "Panda"),
                           Animal(image: "🐻‍❄️", name: "Polar Bear"),
                           Animal(image: "🐨", name: "Koala")
                          ]
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var dataSource = { self.configureDataSource() }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var config = UICollectionLayoutListConfiguration(appearance: .sidebar)
        config.trailingSwipeActionsConfigurationProvider = { [weak self] (indexPath) in
            guard let self = self else { return nil }
            guard let item = self.dataSource.itemIdentifier(for: indexPath) else { return nil }
            return self.trailingSwipeActionConfigurationForListCellItem(item)
        }
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        self.collectionView.collectionViewLayout = layout
        
        // Set Data Source
        self.collectionView.dataSource = dataSource
        
        // Update List
        self.updateList()
    }
    
    func trailingSwipeActionConfigurationForListCellItem(_ item: Animal) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (_, _, completion) in
            self.animals.removeAll { $0.name == item.name}
            self.updateList()
            completion(true)
        }
        
        let shareAction = UIContextualAction(style: .normal, title: "Share") {
            (_, _, completion) in
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction, shareAction])
    }
    
    private func updateList() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Animal>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(self.animals, toSection: .emoji)
        self.dataSource.apply(snapshot)
    }

    private func configureDataSource() -> UICollectionViewDiffableDataSource<Section, Animal> {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Animal> {
            cell, indexPath, item in
            var config = cell.defaultContentConfiguration()
            config.text = item.name
            config.secondaryText = item.image
            cell.contentConfiguration = config
        }
        
        return UICollectionViewDiffableDataSource<Section, Animal>(collectionView: self.collectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }
    }
}

