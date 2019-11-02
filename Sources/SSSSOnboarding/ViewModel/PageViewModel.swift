//
//  File.swift
//
//
//  Created by Besar Ismaili on 29/10/2019.
//

import UIKit

struct PageViewModel {
    let image: UIImage
    let attributedText: NSAttributedString
    let textColor: UIColor
    let fontName: String
    
    //Dependency Injection
    init(page: Page, textColor: UIColor, fontName: String) {
        self.textColor = textColor
        self.fontName = fontName
        let titleFont = UIFont(name: "\(fontName)-bold", size: 26) ?? UIFont.boldSystemFont(ofSize: 26)
        let descriptionFont = UIFont(name: fontName, size: 18) ?? UIFont.systemFont(ofSize: 18)
        self.image = UIImage(named: page.image) ?? UIImage()

        //setting the attributed text
        let attributedString = NSMutableAttributedString(string: page.header, attributes: [NSAttributedString.Key.font: titleFont, NSAttributedString.Key.foregroundColor: textColor])
        attributedString.append(NSAttributedString(string: "\n\n\(page.description)", attributes: [NSAttributedString.Key.font: descriptionFont, NSAttributedString.Key.foregroundColor: UIColor.gray]))

        self.attributedText = attributedString
    }
}
