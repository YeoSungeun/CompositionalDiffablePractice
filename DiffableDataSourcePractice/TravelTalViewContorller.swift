//
//  TravelTalViewContorller.swift
//  DiffableDataSourcePractice
//
//  Created by 여성은 on 7/19/24.
//

import UIKit

final class TravelTalViewContorller: UIViewController {
    var searchBar = {
        let view = UISearchBar()
        view.placeholder = "친구 이름을 검색해보세요"
        return view
    }()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    var datasource: UICollectionViewDiffableDataSource<Int, ChatRoom>!
    var snapshot = NSDiffableDataSourceSnapshot<Int, ChatRoom>()
    
    var list: [ChatRoom] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        setDataSource()
        updateSnapshot()
    }
    func setView() {
        view.backgroundColor = .systemBackground
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.backgroundColor = .systemBackground
        config.showsSeparators = false
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    func setDataSource() {
        var registration: UICollectionView.CellRegistration<UICollectionViewCell, ChatRoom>!
        registration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            let image = itemIdentifier.chatroomImage.count == 1 ? UIImage(named: itemIdentifier.chatroomImage[0]) : UIImage(systemName: "person.circle")
            content.image = image
            content.imageProperties.maximumSize.height = 50
            content.imageProperties.maximumSize.width = 50
            content.imageProperties.reservedLayoutSize = CGSize(width: 50, height: 50)
            content.imageProperties.cornerRadius = 25
            content.text = itemIdentifier.chatroomName
            content.textProperties.font = .boldSystemFont(ofSize: 13)
            content.secondaryText = itemIdentifier.chatList[0].message
            content.secondaryTextProperties.font = .systemFont(ofSize: 12)
            content.secondaryTextProperties.numberOfLines = 1
            // MARK: 야매로 처리 함 해결하기..
            content.textToSecondaryTextHorizontalPadding = 500
            content.textToSecondaryTextVerticalPadding = 16
            cell.contentConfiguration = content
        })
        
        // cellForRowAt역할
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        })
    }
    func updateSnapshot() {
        snapshot.appendSections([0])
        snapshot.appendItems(mockChatList, toSection: 0)
         
        datasource.apply(snapshot)
    }
}

extension TravelTalViewContorller: UISearchBarDelegate {
}

