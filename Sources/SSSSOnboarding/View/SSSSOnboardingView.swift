//
//  SSSSOnboardingHelper.swift
//  testingmylib
//
//  Created by Besar Ismaili on 31/10/2019.
//  Copyright © 2019 Besar Ismaili. All rights reserved.
//

import UIKit


extension SSSSOnboardingViewController {
    func handle(themeColor: UIColor) {
        leftButton.setTitleColor(themeColor, for: .normal)
        rightButton.setTitleColor(themeColor, for: .normal)
        prevButton.setTitleColor(themeColor, for: .normal)
        nextButton.setTitleColor(themeColor, for: .normal)
        actionButton.backgroundColor = themeColor
        pageController.currentPageIndicatorTintColor = themeColor
    }
    
    func handle(fontName: String) {
        leftButton.titleLabel?.font =  UIFont.getFont(with: fontName)
        rightButton.titleLabel?.font = UIFont.getFont(with: fontName)
        prevButton.titleLabel?.font = UIFont.getFont(with: fontName)
        nextButton.titleLabel?.font = UIFont.getFont(with: fontName)
        actionButton.titleLabel?.font = UIFont.getFont(with: fontName)
        prevButton.titleLabel?.font = UIFont.getFont(with: fontName)
    }
            
    func setupViews() {
        //upper buttons
        view.addSubview(rightButton)
        view.addSubview(leftButton)
        
        //closeButton
        NSLayoutConstraint.activate([
            leftButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            leftButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            leftButton.widthAnchor.constraint(equalToConstant: 65),
            leftButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        //laterButton
        NSLayoutConstraint.activate([
            rightButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            rightButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            rightButton.widthAnchor.constraint(equalToConstant: 65),
            rightButton.heightAnchor.constraint(equalToConstant: 48)
        ])

        //bottomStackView
        bottomStackView = UIStackView(arrangedSubviews: [prevButton, pageController, nextButton])
        bottomStackView.distribution = .fillEqually
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomStackView)

        //Auto-layout for the bottomStackView
        //Another way of activating the constraints, NSLayoutConstraint.activate([]) == .isActive = true
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //actionButton
        view.addSubview(actionButton)
        handleActionButtonConstraints()
    }
    
    
    fileprivate func handleActionButtonConstraints() {
        actionButton.removeAllConstraints()
        if UIDevice.current.orientation != .portrait {
            NSLayoutConstraint.activate([
                actionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
                actionButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: ((view.frame.width / 3) / 4)),
                actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
                actionButton.heightAnchor.constraint(equalToConstant: 50),
            ])
        } else {
            NSLayoutConstraint.activate([
                actionButton.bottomAnchor.constraint(equalTo: bottomStackView.topAnchor, constant: -25),
                actionButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
                actionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
                actionButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        actionButton.layoutIfNeeded()
    }
    
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //Accesses the instance referenced by this pointer -> pointee
        let x = targetContentOffset.pointee.x
        let currentPage = Int(x / view.frame.width)
        pageController.currentPage = currentPage
        //checkout what it prints:
        print(x, view.frame.width, currentPage)
        
        //handle button hiding
        handleButtonHidding(currentPage: currentPage)
    }
    
    //This function fixes the rotation bug
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (_) in
            self.collectionView.collectionViewLayout.invalidateLayout()
            if self.pageController.currentPage == 0 {
                self.collectionView.contentOffset = .zero
            }
            else {
                let indexPath = IndexPath(item: self.pageController.currentPage, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            self.handleActionButtonConstraints()
        }) { (_) in
        }
    }
    
    func handleButtonHidding(currentPage: Int) {
        //handle button hiding
        prevButton.alpha = currentPage == 0 ? 0 : 1
        nextButton.alpha = currentPage == (pageViewModels.count - 1) ? 0 : 1
        actionButton.isHidden = currentPage == (pageViewModels.count - 1) && !isActionButtonHidden ? false : true
    }
}
