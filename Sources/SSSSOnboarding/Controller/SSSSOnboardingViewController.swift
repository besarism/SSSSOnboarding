//
//  File.swift
//  
//
//  Created by Besar Ismaili on 29/10/2019.
//


import UIKit

open class SSSSOnboardingViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    fileprivate let cellId = "cellId"
    
    var pageViewModels = [PageViewModel]()
    
    open var pages = [Page]() {
        didSet {
            pageController.numberOfPages = pageViewModels.count
            pageViewModels = pages.map({ return PageViewModel(page: $0)})
        }
    }
    
    var rightButtonTitle = "" {
        didSet {
            rightButton.setTitle(rightButtonTitle, for: .normal)
        }
    }
    
    var leftButtonTitle = "" {
        didSet {
            leftButton.setTitle(leftButtonTitle, for: .normal)
        }
    }
    //FIXME: on font change update views
//    var fontName = "" {
//        didSet {
//
//        }
//    }

    
    private lazy var rightButton: UIButton =  {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(prevPage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private var leftButton: UIButton =  {
           let button = UIButton(type: .system)
           button.backgroundColor = .clear
           button.setTitle("Later", for: .normal)
           button.setTitleColor(.gray, for: .normal)
           button.titleLabel?.font = .boldSystemFont(ofSize: 15)
           button.addTarget(self, action: #selector(prevPage), for: .touchUpInside)
           button.translatesAutoresizingMaskIntoConstraints = false
           
           return button
       }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        
        return cv
    }()
    
    //Bottom Stack View
    private var prevButton: UIButton =  {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("PREV", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(prevPage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        
        return button
    }()
    
    private var nextButton: UIButton =  {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    @objc private func nextPage() {
        let index = min(pageController.currentPage + 1, pageViewModels.count - 1)
        let indexPath = IndexPath(item: index, section: 0)
        pageController.currentPage = index
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func prevPage() {
        let index = max(pageController.currentPage - 1, 0)
        let indexPath = IndexPath(item: index, section: 0)
        pageController.currentPage = index
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    private var pageController: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = .green
        pc.pageIndicatorTintColor = UIColor.lightGray
        pc.translatesAutoresizingMaskIntoConstraints = false
        
        return pc
    }()
    
    
    
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        //setupViews
        setupCollectionView()
        setupViews()
    }
    
    open func setupCollectionView() {
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
    
    
    open func setupViews() {
        //upper buttons
        view.addSubview(rightButton)
        view.addSubview(leftButton)
        
        //closeButton
        NSLayoutConstraint.activate([
            rightButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            rightButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            rightButton.widthAnchor.constraint(equalToConstant: 56),
            rightButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        //laterButton
        NSLayoutConstraint.activate([
            leftButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            leftButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            leftButton.widthAnchor.constraint(equalToConstant: 56),
            leftButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        
        //bottomStackView
        let bottomStackView = UIStackView(arrangedSubviews: [prevButton, pageController, nextButton])
        bottomStackView.distribution = .fillEqually
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomStackView)
        
        //Auto-layout for the bottomStackView
        //Another way of activating the constraints, NSLayoutConstraint.activate([]) == .isActive = true
        NSLayoutConstraint.activate([
            bottomStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomStackView.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    
    open func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        //Accesses the instance referenced by this pointer -> pointee
        let x = targetContentOffset.pointee.x
        let currentPage = Int(x / view.frame.width)
        pageController.currentPage = currentPage
        //checkout what it prints:
        print(x, view.frame.width, currentPage)
    }
    
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
            
        }) { (_) in
            
        }
    }
    
    
}

