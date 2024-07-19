//
//  SettingViewController.swift
//  DiffableDataSourcePractice
//
//  Created by 여성은 on 7/19/24.
//

import UIKit
import SnapKit

enum SettingOption: Int, CaseIterable {
    case all
    case personal
    case etc
    
    var mainOption: String {
        switch self {
        case .all:
            "전체 설정"
        case .personal:
            "개인 설정"
        case .etc:
            "기타"
        }
    }
    var subOptions: [String] {
        switch self {
        case .all:
            ["공지사항", "실험실", "버전 정보"]
        case .personal:
            ["개인/보안", "알림", "채팅" , "멀티프로필"]
        case .etc:
            ["고객센터/도움말"]
        }
    }
}

class SettingViewController: UIViewController {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    
    var dataSource: UICollectionViewDiffableDataSource<SettingOption, String>!
//    let list = SettingOption.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurateView()
        configureDataSource()
        updateSnapShot()
    }
    func collectionViewLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        configuration.backgroundColor = .systemBackground
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return layout
    }
    func configurateView() {
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        navigationItem.title = "설정"
    }
    func configureDataSource() {
        var registration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            cell.contentConfiguration = content
            
        }
        // cellForRowAt 기능
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        })
        
    }
    func updateSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<SettingOption, String>()

        snapshot.appendSections(SettingOption.allCases)
        for setting in SettingOption.allCases {
            snapshot.appendItems(setting.subOptions, toSection: setting)
        }
        dataSource.apply(snapshot)
    
    }
}
/*
 extension SettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
 func numberOfSections(in collectionView: UICollectionView) -> Int {
 return list.count
 }
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 return list[section].subOptions.count
 }
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: list[indexPath.section].subOptions[indexPath.item])
 return cell
 }
 
 
 }
 */
