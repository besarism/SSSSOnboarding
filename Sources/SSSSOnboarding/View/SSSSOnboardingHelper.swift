//
//  File.swift
//  
//
//  Created by Besar Ismaili on 01/11/2019.
//

import UIKit

extension SSSSOnboardingViewController {
    
    func handle(themeColor: UIColor) {
        leftButton.setTitleColor(themeColor, for: .normal)
        rightButton.setTitleColor(themeColor, for: .normal)
        prevButton.setTitleColor(themeColor, for: .normal)
        nextButton.setTitleColor(themeColor, for: .normal)
        pageController.currentPageIndicatorTintColor = themeColor
    }
    
    func handle(fontName: String) {
        leftButton.titleLabel?.font = getFont(with: fontName)
        rightButton.titleLabel?.font = getFont(with: fontName)
        prevButton.titleLabel?.font = getFont(with: fontName)
        nextButton.titleLabel?.font = getFont(with: fontName)
        prevButton.titleLabel?.font = getFont(with: fontName)
    }
    
    func getFont(with fontName: String) -> UIFont {
        return UIFont(name: fontName, size: 15) ?? UIFont.systemFont(ofSize: 15)
    }
}

