//
//  CardsMenuTableViewCell.swift
//  Cuisine101
//
//  Created by Rayane Xavier on 15/01/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import UIKit

class CardsMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var imageRecipeCardMenu: UIImageView!
    
    @IBOutlet weak var labelNameRecipeCardMenu: UILabel!
    
    @IBOutlet weak var labelTimeRecipeCardMenu: UILabel!
    
    @IBOutlet weak var labelPeopleRecipeCardMenu: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
