//
//  ModelCollectionViewCell.swift
//  Cuisine101
//
//  Created by Nathalia Melare on 17/01/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import UIKit

class RecepieCollectionViewCell: UICollectionViewCell {
    
    let image: UIImage = UIImage(named: "CebolaPagina")!
    let label: UILabel = {
        let label = UILabel()
        label.text = "FUNFOU"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 20)
        label.backgroundColor = UIColor.red
        return label
    }()
    
    
}
