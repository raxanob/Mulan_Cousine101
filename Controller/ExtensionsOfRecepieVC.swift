//
//  ExtensionsOfRecepieVC.swift
//  Cuisine101
//
//  Created by Rayane Xavier on 03/04/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import UIKit

extension RecepieViewController: UICollectionViewDelegateFlowLayout  {
    
}

extension RecepieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 70, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return renevue.ingredientes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellRecepie", for: indexPath) as! IngredientsCollectionViewCell
        
        //Configure cell with photo from parent ViewController
        for i in 0...renevue.ingredientes.count - 1 {
            data.append(RecepieViewController.Ingredient.init(name: renevue.ingredientes[i], image: UIImage(named: renevue.imagensDosIngredientes[i])!, dose: renevue.quantidade[i]))
        }
        cell.data = self.data[indexPath.row]
        return cell
    }
}
