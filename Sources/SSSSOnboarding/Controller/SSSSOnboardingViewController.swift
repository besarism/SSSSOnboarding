//
//  File.swift
//
//
//  Created by Besar Ismaili on 29/10/2019.
//


import UIKit

open class SSSSOnboardingViewController: UIViewController {
    
    let cellId = "cellId"
    
    var pageViewModels = [PageViewModel]()
        
    open var pages = [Page]() {
        didSet {
            pageController.numberOfPages = pages.count
            pageViewModels = pages.map({ return PageViewModel(page: $0, textColor: themeColor, fontName: fontName)})
        }
    }
    
    open var rightButtonTitle = "" {
        didSet {
            rightButton.setTitle(rightButtonTitle, for: .normal)
        }
    }
    
    open var leftButtonTitle = "" {
        didSet {
            leftButton.setTitle(leftButtonTitle, for: .normal)
        }
    }
    
    open var actionButtonTitle = "" {
        didSet {
            actionButton.setTitle(actionButtonTitle, for: .normal)
        }
    }
    
    open var isRightButtonHidden = false {
        didSet {
            rightButton.isHidden = isRightButtonHidden
        }
    }
    
    open var isLeftButtonHidden = false {
        didSet {
            leftButton.isHidden = isLeftButtonHidden
        }
    }
    
    open var isActionButtonHidden = false
    
    open var prevButtonTitle = "" {
        didSet {
            prevButton.setTitle(prevButtonTitle, for: .normal)
        }
    }
    
    open var nextButtonTitle = "" {
        didSet {
            nextButton.setTitle(nextButtonTitle, for: .normal)
        }
    }
    
    open var themeColor = UIColor.black {
        didSet {
            handle(themeColor: themeColor)
            pageViewModels = pages.map({ return PageViewModel(page: $0, textColor: themeColor, fontName: fontName)})
        }
    }
    
    open var fontName = "HelveticaNeue" {
        didSet {
            handle(fontName: fontName)
            pageViewModels = pages.map({ return PageViewModel(page: $0, textColor: themeColor, fontName: fontName)})
        }
    }
    
    lazy var rightButton: UIButton =  {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleRightButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var leftButton: UIButton =  {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("Later", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleLeftButton), for: .touchUpInside)
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
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    var actionButton: UIButton =  {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleActionButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.isHidden = true
        
        return button
    }()
    
    //Bottom Stack View
    var prevButton: UIButton =  {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("PREV", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(prevPage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.alpha = 0
        
        return button
    }()
    
    var nextButton: UIButton =  {
        let button = UIButton(type: .system)
        button.backgroundColor = .clear
        button.setTitle("NEXT", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var bottomStackView = UIStackView()
        
    var pageController: UIPageControl = {
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
    
    //MARK: - Bottom button methods
    @objc private func nextPage() {
        let index = min(pageController.currentPage + 1, pageViewModels.count - 1)
        let indexPath = IndexPath(item: index, section: 0)
        pageController.currentPage = index
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        handleButtonHidding(currentPage: index)
    }
    
    @objc private func prevPage() {
        let index = max(pageController.currentPage - 1, 0)
        let indexPath = IndexPath(item: index, section: 0)
        pageController.currentPage = index
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        handleButtonHidding(currentPage: index)
    }
    
    @objc open func handleLeftButton() { }
    @objc open func handleRightButton() { }
    @objc open func handleActionButton() { }

}
