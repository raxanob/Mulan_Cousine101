//
//  CollectionViewCell.swift
//  Cuisine101
//
//  Created by Rayane Xavier on 24/01/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import UIKit

class IngredientsCollectionViewCell: UICollectionViewCell {
    
    var renevue: Receita!
    
    var data: RecepieViewController.Ingredient? {
        didSet {
            guard let data = data else { return }
            nameOfIngredientLabel.text = data.name
            imageOfIngredient.image = data.image
            doseOfIngredientLabel.text = data.dose
        }
    }
    
    fileprivate let imageOfIngredient: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    fileprivate let nameOfIngredientLabel: UILabel = {
        let lbn = UILabel()
        lbn.translatesAutoresizingMaskIntoConstraints = false
        lbn.clipsToBounds = true
        lbn.textColor = #colorLiteral(red: 0.9320240021, green: 0.7159546018, blue: 0.3065403104, alpha: 0.8470588235)
        lbn.font = UIFont.systemFont(ofSize: 16.0)
        lbn.textAlignment = .center
        return lbn
    }()
    
    fileprivate let doseOfIngredientLabel: UILabel = {
        let lbd = UILabel()
        lbd.translatesAutoresizingMaskIntoConstraints = false
        lbd.clipsToBounds = true
        lbd.textColor = #colorLiteral(red: 0.6926782727, green: 0.6750221848, blue: 0.671228528, alpha: 0.8470588235)
        lbd.font = UIFont.systemFont(ofSize: 14.0)
        lbd.textAlignment = .center
        return lbd
    }()

    
     override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(nameOfIngredientLabel)
        contentView.addSubview(imageOfIngredient)
        contentView.addSubview(doseOfIngredientLabel)
    nameOfIngredientLabel.topAnchor.constraint(equalTo:contentView.topAnchor).isActive = true
        nameOfIngredientLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        nameOfIngredientLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        imageOfIngredient.topAnchor.constraint(equalTo: nameOfIngredientLabel.bottomAnchor).isActive = true
        imageOfIngredient.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        imageOfIngredient.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        doseOfIngredientLabel.topAnchor.constraint(equalTo: imageOfIngredient.bottomAnchor,constant: -1).isActive = true
        doseOfIngredientLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        doseOfIngredientLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        doseOfIngredientLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

