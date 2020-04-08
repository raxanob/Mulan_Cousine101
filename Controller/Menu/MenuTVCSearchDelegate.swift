//
//  MenuTVCSearchDelegate.swift
//  Cuisine101
//
//  Created by Rayane Xavier on 02/04/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import UIKit

// MARK: - Delegate of searchBar
extension MenuTableViewController: UISearchBarDelegate {
    func creatSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = false
        searchBar.placeholder = "Ingredientes"
        self.navigationItem.titleView = searchBar
    }
}
