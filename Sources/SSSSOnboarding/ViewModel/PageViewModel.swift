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
    
    init(page: Page) {
        self.image = UIImage(named: page.image) ?? UIImage()
        
        //setting the attributed text
        let attributedString = NSMutableAttributedString(string: page.header, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
        attributedString.append(NSAttributedString(string: "\n\n\n\(page.description)", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))

        self.attributedText = attributedString
    }
}
