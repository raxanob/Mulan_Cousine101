//
//  BlackBackgroundAnimation.swift
//  Cuisine101
//
//  Created by Nathalia Melare on 16/01/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import Foundation
import UIKit

class SettingsModal: NSObject {
    
    let height:CGFloat = 600
    let blackView = UIView()
    
    var tutorialCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let tutorialCollectionInformation = UICollectionView(frame: .zero, collectionViewLayout: layout)
        if #available(iOS 13.0, *) {
            tutorialCollectionInformation.backgroundColor = UIColor.systemGray6
        } else {
           tutorialCollectionInformation.backgroundColor = UIColor.white
        }
        return tutorialCollectionInformation
    }()
        
    var tutorialCollectionViewDataSource = TutorialCollectionViewDataSource()
    var tutorialCollectionViewDelegate = TutorialCollectionViewDelegate()
    
    init(recipe: Receita) {
        super .init()
        
        tutorialCollectionView.dataSource = tutorialCollectionViewDataSource
        tutorialCollectionView.delegate = tutorialCollectionViewDelegate
        tutorialCollectionViewDataSource.text = recipe.dicas
        tutorialCollectionViewDataSource.title = recipe.nomeDaDica
        tutorialCollectionView.register(TutorialCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        
    }
    
   // MARK: - Set Up Background Color
    func handleMore() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
                   
            blackView.alpha = 0
            blackView.frame = window.frame
            
            window.addSubview(blackView)
        }
    }
    // MARK: - Set Up Animation Clicked
    func firstAnimationModal() {
        if let window = UIApplication.shared.keyWindow {
            let y = window.frame.height - height
            UIView.animate(withDuration: 0.5) {
                self.blackView.alpha = 1
                self.tutorialCollectionView.frame = CGRect(x: 0, y: y, width: self.tutorialCollectionView.frame.width, height: self.tutorialCollectionView.frame.height)
            }
        }
    }
    // MARK: - Set Up CollectionView
    func collectionViewSetUp() {
        if let window = UIApplication.shared.keyWindow {
            
            tutorialCollectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            tutorialCollectionView.layer.cornerRadius = 30
            
            window.addSubview(tutorialCollectionView)
        }
    }
    // MARK: - Set Up Animation Dismiss
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.tutorialCollectionView.frame = CGRect (x: 0, y: window.frame.height, width: self.tutorialCollectionView.frame.width, height: self.tutorialCollectionView.frame.height)
            }
        }
    }
}
