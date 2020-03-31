//
//  RecepieCollectionViewDataSouce.swift
//  Cuisine101
//
//  Created by Nathalia Melare on 17/01/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//
import UIKit

class TutorialCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var tutorials : [Receita] = []
    var text: String!
    var title: String!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? TutorialCollectionViewCell {
            cell.text.font = .systemFont(ofSize: 16)
            cell.text.text = text
            cell.text.textColor = #colorLiteral(red: 0.4980472922, green: 0.4950307012, blue: 0.5003677011, alpha: 1)
            cell.text.isEditable = false
            cell.text.backgroundColor = .none
            
            cell.title.text = title
            cell.title.textColor = #colorLiteral(red: 0.9320240021, green: 0.7159546018, blue: 0.3065403104, alpha: 0.8470588235)
            cell.title.font = .systemFont(ofSize: 20, weight: UIFont.Weight(rawValue: 0.3))
            cell.title.textAlignment = .center
            
            return cell
        }
        return UICollectionViewCell()
    }
    
}
