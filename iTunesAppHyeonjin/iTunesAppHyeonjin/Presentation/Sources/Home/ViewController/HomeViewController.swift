//
//  HomeViewController.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/8/25.
//

import UIKit
import RxSwift
import RxCocoa

enum HomeSection: Int, Hashable {
    case bestSpring = 0
    case spring = 1
    case summer = 2
    case autumn = 3
    case winter = 4
}

enum HomeSectionItem: Hashable {
    case bestSpring(Track)
    case spring(Track)
    case summer(Track)
    case autumn(Track)
    case winter(Track)
}

final class HomeViewController: UIViewController {
    private let homeView = HomeView()
    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()
    
    private var dataSource: UICollectionViewDiffableDataSource<HomeSection, HomeSectionItem>!
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAttributes()
        setDataSource()
        bind()
    }
    
    private func applySnapshot(items: [HomeSectionItem]) {
        var snapshot = NSDiffableDataSourceSnapshot<HomeSection, HomeSectionItem>()
        snapshot.appendSections([.bestSpring, .spring, .summer, .autumn, .winter])
        
        snapshot.appendItems(
            items.filter {
                if case .bestSpring = $0 { return true }
                return false
            },
            toSection: .bestSpring
        )
        
        snapshot.appendItems(
            items.filter {
                if case .spring = $0 { return true }
                return false
            },
            toSection: .spring
        )
        
        snapshot.appendItems(
            items.filter {
                if case .summer = $0 { return true }
                return false
            },
            toSection: .summer)
        
        snapshot.appendItems(
            items.filter {
                if case .autumn = $0 { return true }
                return false
            },
            toSection: .autumn)
        
        snapshot.appendItems(
            items.filter {
                if case .winter = $0 { return true }
                return false
            },
            toSection: .winter)
        
        dataSource.apply(snapshot)
    }
}

extension HomeViewController {
    private func bind() {
        viewModel.action.accept(.fetchSeasonMusic)
        
        viewModel.state
            .map(\.seasonMusic)
            .asDriver(onErrorJustReturn: [])
            .drive { [weak self] in
                guard let self else { return }
                applySnapshot(items: $0)
            }
            .disposed(by: disposeBag)
    }
}

private extension HomeViewController {
    func setAttributes() {
        title = "Music"
        view.backgroundColor = .systemBackground
        navigationItem.searchController = homeView.searchController
    }
    
    func setDataSource() {
        dataSource = UICollectionViewDiffableDataSource(
            collectionView: homeView.homeCollectionView,
            cellProvider: { collectionView, indexPath, item in
                switch item {
                case .bestSpring(let track):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BestMusicCollectionViewCell.reuseIdentifier, for: indexPath) as? BestMusicCollectionViewCell else { return UICollectionViewCell() }
                    cell.configure(track: track)
                    return cell
                case .spring(let track), .summer(let track), .autumn(let track), .winter(let track):
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonMusicCollectionViewCell.reuseIdentifier, for: indexPath) as? SeasonMusicCollectionViewCell else { return UICollectionViewCell() }
                    cell.configure(track: track)
                    return cell
                }
        })
        
        dataSource.supplementaryViewProvider = { collectionView, _, indexPath -> UICollectionReusableView? in
            guard let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: SectionHeader.identifier,
                for: indexPath
            ) as? SectionHeader else { return nil }
            
            switch indexPath.section {
            case 0: headerView.configure(title: "봄 Best", subTitle: "봄에 어울리는 음악 Best 10")
            case 1: headerView.configure(title: "봄", subTitle: "봄에 어울리는 음악")
            case 2: headerView.configure(title: "여름", subTitle: "여름에 어울리는 음악")
            case 3: headerView.configure(title: "가을", subTitle: "가을에 어울리는 음악")
            case 4: headerView.configure(title: "겨울", subTitle: "겨울에 어울리는 음악")
            default:
                break
            }
            return headerView
        }
    }
}
