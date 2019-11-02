//
//  File.swift
//  
//
//  Created by Besar Ismaili on 02/11/2019.
//

import UIKit

extension SSSSOnboardingViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func setupCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.isPagingEnabled = true
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    //MARK: - CollectionView
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return pageViewModels.count
     }
     
     open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
         let pageViewModel = pageViewModels[indexPath.item]
         cell.pageViewModel = pageViewModel
         
         return cell
     }
     
     open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         return CGSize(width: view.frame.width, height: view.frame.height)
     }
     
     open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 0
     }
}
