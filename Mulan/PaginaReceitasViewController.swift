//
//  PaginaReceitas.swift
//  Mulan
//
//  Created by Nathalia Melare on 09/05/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//
import Foundation
import UIKit

class ReceitaViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    

    var recepies: [Receitaz] = []
    
    var filtereceitas: [Receitaz] = []
    
    override func viewDidLoad() {
//        tableView.estimatedRowHeight = 150
        
        super.viewDidLoad()
        
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.tintColor = .init(red: 157/255, green: 20/255, blue: 28/255, alpha: 1)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Pesquisar ingredientes"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        recepies = Intern.getAllRecepies()

        tabBarController?.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering(){
            return filtereceitas.count
        }
        return recepies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: "imagemCard") as? ReceitaCellCards {
            
            if isFiltering(){
                cell.imagemView.image = UIImage(named: filtereceitas[indexPath.row].nomeDaImagem)
            } else {
                cell.imagemView.image = UIImage(named: recepies[indexPath.row].nomeDaImagem)

            }
            return cell
 
        }
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var recepie = recepies[indexPath.row]
        if isFiltering(){
            recepie = filtereceitas[indexPath.row]
        }
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PaginaReceita") as? PaginaReceita {
            viewController.comidinha = recepie
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String) {
         filtereceitas = recepies.filter({( recepie : Receitaz) -> Bool in
            for ingrediente in recepie.ingredientes {
                if ingrediente.lowercased().contains(searchText.lowercased()){
                    return true
                }
            }
            return false
        })
        
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
}

extension ReceitaViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
