//
//  ViewController.swift
//  CupidMatch
//
//  Created by Joseph Ugowe on 4/8/18.
//  Copyright © 2018 Joseph Ugowe. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    let networkManager = NetworkManager()
    var viewModels = [CollectionViewCellViewModelProtocol]()
    var userArray: [User] = []
    
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 50.0, right: 12.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildViewModels()
        setupView()
    }
    
    private func setupView() {
        self.title = "Browse"
        let titleColor = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = titleColor
    }
    
    private func buildViewModels() {
        networkManager.fetchUserData { (results, errorMessage) in
            if let results = results {
                let users = results
                self.viewModels = users.map({ UserCollectionViewCellViewModelFactory(user: $0, viewController: self).create() })
                self.collectionView.reloadData()
            }
        }
    }
}

extension UsersViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = viewModels[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.identifier, for: indexPath)
        viewModel.commands[.configuration]?.perform(arguments: [.cell: cell])
        return cell
    }
}

extension UsersViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return formatCellSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
    
    private func formatCellSize() -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let cellAspectRatio = CGFloat(194.0/166.5)
        
        let availableWidth: CGFloat = view.frame.size.width - paddingSpace
        let cellWidth = availableWidth / itemsPerRow
        
        let userInfoHeight: CGFloat = 101.0
        let imageHeight = cellWidth * cellAspectRatio
        let cellHeight = imageHeight + userInfoHeight
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

