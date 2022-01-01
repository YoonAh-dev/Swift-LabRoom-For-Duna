//
//  FeedItemViewController.swift
//  HealthKit-Practice
//
//  Created by SHIN YOON AH on 2021/12/06.
//

import UIKit
import HealthKit

class DataTypeCollectionViewController: UIViewController {
    static let cellIdentifier = "DataTypeCollectionViewCell"
    
    // MARK: - Properties
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.register(DataTypeCollectionViewCell.self, forCellWithReuseIdentifier: Self.cellIdentifier)
        
        return collectionView
    }()
    
    var data: [(dataTypeIdentifier: String, values: [Double])] = []
    
    // MARK: - Initalizers
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setUpViews()
        
        title = tabBarItem.title
        view.backgroundColor = .systemBackground
        collectionView.backgroundColor = .systemBackground
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        collectionView.setCollectionViewLayout(makeLayout(), animated: true)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    // MARK: - View Helper Functions
    
    private func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setUpViews() {
        view.addSubview(collectionView)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        constraints += createCollectionViewConstraints()
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createCollectionViewConstraints() -> [NSLayoutConstraint] {
        return [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
    }
    
    private func makeLayout() -> UICollectionViewLayout {
        let verticalMargin: CGFloat = 8
        let horizontalMargin: CGFloat = 20
        let interGroupSpacing: CGFloat = horizontalMargin
        
        let cellHeight = calculateCellHeight(horizontalMargin: horizontalMargin,
                                             verticalMargin: verticalMargin)
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(cellHeight))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(cellHeight))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = interGroupSpacing
        section.contentInsets = .init(top: verticalMargin, leading: horizontalMargin, bottom: verticalMargin, trailing: horizontalMargin)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func calculateCellHeight(horizontalMargin: CGFloat, verticalMargin: CGFloat) -> CGFloat {
        let isLandscape = UIApplication.shared.isLandscape
        let widthInset = (horizontalMargin * 2) + view.safeAreaInsets.left + view.safeAreaInsets.right
        var heightInset = (verticalMargin * 2)
        
        heightInset += navigationController?.navigationBar.bounds.height ?? 0
        heightInset += tabBarController?.tabBar.bounds.height ?? 0
        
        let cellHeight = isLandscape ? view.bounds.height - heightInset : view.bounds.width - widthInset
        return cellHeight
    }
}

extension DataTypeCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let content = data[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Self.cellIdentifier, for: indexPath) as? DataTypeCollectionViewCell else { return DataTypeCollectionViewCell() }
        
        cell.updateChartView(with: content.dataTypeIdentifier, values: content.values)
        
        return cell
    }
}
