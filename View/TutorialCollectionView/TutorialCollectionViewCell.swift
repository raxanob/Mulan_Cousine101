//
//  RecepieCollectionViewCell.swift
//  Cuisine101
//
//  Created by Nathalia Melare on 17/01/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import UIKit

class TutorialCollectionViewCell: UICollectionViewCell {
    
    let text = UITextView()
    let title = UILabel()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
      // MARK: - Set Up Constrains Tutorial Text
        addSubview(text)

        addConstrainsWithFormat(format: "H:|-20-[v0]|", views: text)
        addConstrainsWithFormat(format: "V:|-40-[v0]|", views: text)
        addConstraints([NSLayoutConstraint(item: text, attribute: .topMargin, relatedBy: .equal, toItem: self, attribute: .topMargin, multiplier: 1, constant: 0)])
            
        text.frame.size = CGSize(width: UIScreen.main.bounds.size.width - 20, height: 600)
        
        // MARK: - Set Up Constrains Tutorial Title
        addSubview(title)
        
        addConstrainsWithFormat(format: "H:|[v0]|", views: title)
        addConstrainsWithFormat(format: "V:|-(-450)-[v0]|", views: title)
        
        // MARK: - Set Up Background Color
        if #available(iOS 13.0, *) {
            self.backgroundColor = UIColor.systemGray6
        } else {
            self.backgroundColor = UIColor.white
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
