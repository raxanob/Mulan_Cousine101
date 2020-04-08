//
//  ExtensionsOfRecepieVC.swift
//  Cuisine101
//
//  Created by Rayane Xavier on 03/04/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import UIKit
import CloudKit

extension RecepieViewController: UICollectionViewDelegateFlowLayout  {
    
}

extension RecepieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellRecepie", for: indexPath) as! IngredientsCollectionViewCell
        
        //Configure cell with photo from parent ViewController
        cell.data = self.data[indexPath.row]
        return cell
    }
}
