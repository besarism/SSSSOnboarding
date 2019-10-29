//
//  File.swift
//  
//
//  Created by Besar Ismaili on 29/10/2019.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var pageViewModel: PageViewModel! {
        didSet {
            iconImageView.image = pageViewModel.image
            titleTextView.attributedText = pageViewModel.attributedText
        }
    }
    
    
    private var topiImageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
   private var iconImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        //translatesAutoresizingMaskIntoConstraints enables conctraints for the view it "self"
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
     private var titleTextView: UITextView = {
        let textView = UITextView()
        //replace the textView.text with NSMutableAttributedString
        let attributedString = NSMutableAttributedString(string: "This is just a title text for the autolayout programatically", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)])
        attributedString.append(NSAttributedString(string: "\n\n\nFar far away, behind the word mountains, far from the countries, Far far away, behind the word mountains, far from the countries", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        textView.attributedText = attributedString
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    
    
    func setupViews() {
        //Here in this function we are going to setup views and autolayout
        //       addSubview(iconImageView) -> we add the iconImageView to the topiImageContainerView
       addSubview(titleTextView)
       addSubview(topiImageContainerView)
        topiImageContainerView.addSubview(iconImageView)
        
        //add .isActive = true to activate the constraints
        
        //Auto-layout for the topiImageContainerView
        topiImageContainerView.leadingAnchor.constraint(equalTo:leadingAnchor).isActive = true
        topiImageContainerView.trailingAnchor.constraint(equalTo:trailingAnchor).isActive = true
        topiImageContainerView.topAnchor.constraint(equalTo:topAnchor).isActive = true
        //Here is the tricky part, we make the topiImageContainerView half of the screen so when device rotates imageView is still there
        topiImageContainerView.heightAnchor.constraint(equalTo:heightAnchor, multiplier: 0.5).isActive = true
        
        //Auto-layout for the iconImageView
        iconImageView.centerXAnchor.constraint(equalTo: topiImageContainerView.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: topiImageContainerView.centerYAnchor).isActive = true
        iconImageView.heightAnchor.constraint(equalTo: topiImageContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        
        //Auto-layout for the titleTextView
        titleTextView.topAnchor.constraint(equalTo: topiImageContainerView.bottomAnchor).isActive = true
        titleTextView.leadingAnchor.constraint(equalTo:leadingAnchor, constant: 24).isActive = true
        titleTextView.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -24).isActive = true
        titleTextView.bottomAnchor.constraint(equalTo:bottomAnchor, constant: 0).isActive = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
