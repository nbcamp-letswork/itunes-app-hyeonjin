//
//  HomeView.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/10/25.
//

import UIKit
import SnapKit

final class HomeView: UIView {
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "영화, 팟캐스트"
        return searchController
    }()
    
    lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            guard let section = HomeSection(rawValue: sectionIndex) else { return nil }
            return self.createSection(for: section)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SeasonMusicCollectionViewCell.self, forCellWithReuseIdentifier: SeasonMusicCollectionViewCell.reuseIdentifier)
        collectionView.register(BestMusicCollectionViewCell.self, forCellWithReuseIdentifier: BestMusicCollectionViewCell.reuseIdentifier)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttribute()
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension HomeView {
    func setAttribute() {
        backgroundColor = .systemBackground
    }
    
    
    func setHierarchy() {
        addSubview(homeCollectionView)
    }
    
    func setConstraints() {
        homeCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

private extension HomeView {
    func createSection(for sectionIndex: HomeSection) -> NSCollectionLayoutSection {
        switch sectionIndex {
        case .bestSpring:
            return makeLargeHorizontalSection()
        case .autumn, .spring, .summer, .winter:
            return makeHorizontalLayout()
        }
    }
    
    func makeLargeHorizontalSection() -> NSCollectionLayoutSection {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(36)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.85),
            heightDimension: .fractionalHeight(0.4)
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item],
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 16, leading: 16, bottom: 32, trailing: 16)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.boundarySupplementaryItems = [header]
        return section
    }
    
    func makeHorizontalLayout() -> NSCollectionLayoutSection {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(36)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1/3)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.85),
            heightDimension: .fractionalHeight(0.4)
        )

        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item],
        )

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 16
        section.contentInsets = .init(top: 12, leading: 16, bottom: 32, trailing: 16)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [header]
        return section
    }
}
