//
//  MenuTableViewController.swift
//  Cuisine101
//
//  Created by Rayane Xavier on 15/01/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import UIKit
import CloudKit

class MenuTableViewController: UITableViewController {

    var filterRenevue = [CKRecord]()
    var recepie = [CKRecord]()

    let searchBar = UISearchBar()
    
    let container = CKContainer.init(identifier: "iCloud.Xuxu")
    let query = CKQuery(recordType: "Receitas", predicate: NSPredicate(value: true))
    lazy var database = container.publicCloudDatabase
        
    // MARK: - Table view data source
    @IBOutlet weak var SegmentedControlOutlet: UISegmentedControl!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        navigationItem.hidesSearchBarWhenScrolling = false
        self.setNeedsStatusBarAppearanceUpdate()
        queryDatabase()
        creatSearchBar()
        filterRenevue = recepie
        setSegmentadControll()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .default
    }
    
    func queryDatabase() {
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else { return }
            if let err = error {
                fatalError(err.localizedDescription)
            } else {
                let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate!})
                self.recepie = sortedRecords
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filterRenevue = recepie
            tableView.reloadData()
            return
        }
        
        let predicate = NSPredicate(format: "NomeIngredientes == %@", searchText.lowercased())
        let query = CKQuery(recordType: "Receitas", predicate: predicate)
        database.perform(query, inZoneWith: nil) {(records, error) in
        if let err = error {
            fatalError(err.localizedDescription)
        } else {
            DispatchQueue.main.async {
                self.filterRenevue = self.recepie.filter({(renevue: CKRecord) -> Bool in
                    if (records?.contains(renevue))!{
                        return true
                    } else {
                        return false
                    }
                    })
                }
            }
        }
        tableView.reloadData()
    }

    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        switch selectedScope {
        case 0:
            filterRenevue = recepie
        case 1:
            filterRenevue = recepie.filter({(renevue: CKRecord) -> Bool in
                renevue.value(forKey: "Categoria") as? String == CategoryOfRenevue.roast.rawValue
            })
        case 2:
            filterRenevue = recepie.filter({(renevue: CKRecord) -> Bool in
                renevue.value(forKey: "Categoria") as? String == CategoryOfRenevue.cooked.rawValue
            })
        case 3:
            filterRenevue = recepie.filter({(renevue: CKRecord) -> Bool in
                renevue.value(forKey: "Categoria") as? String == CategoryOfRenevue.frying.rawValue
            })
        case 4:
            filterRenevue = recepie.filter({(renevue: CKRecord) -> Bool in
                renevue.value(forKey: "Categoria") as? String == CategoryOfRenevue.drink.rawValue
            })
        default:
            break
        }
        tableView.reloadData()
    }
    
    // MARK: - Segmented Controller
    @IBAction func SegmentedControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            filterRenevue = recepie
        case 1:
            filterRenevue = getRoastReceitas()
        case 2:
            filterRenevue = getCookedReceitas()
        case 3:
            filterRenevue = getFriedReceitas()
        case 4:
            filterRenevue = getDrinkReceitas()
        default:
            break
        }
        tableView.reloadData()
    }
    
    func setSegmentadControll() {
        SegmentedControlOutlet.selectedSegmentIndex = 0
        SegmentedControlOutlet.backgroundColor = .clear
        SegmentedControlOutlet.tintColor = .clear
        SegmentedControlOutlet.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: "Avenir-Medium", size: 17) ?? UIFont.boldSystemFont(ofSize: 21),NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.8326148391, green: 0.3012730181, blue: 0.3521553278, alpha: 1)], for: .selected)
        SegmentedControlOutlet.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.init(name: "Avenir-Medium", size: 16) ?? UIFont.boldSystemFont(ofSize: 21),NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
    }
    
    // MARK: - Functions of segmented
    func getRoastReceitas() -> [CKRecord] {
        var roastReceitas: [CKRecord] = []
        for receita in recepie where receita.value(forKey: "Categoria") as? String == "Assados" {
            roastReceitas.append(receita)
        }
        return roastReceitas
    }
    
    
    func getCookedReceitas() -> [CKRecord] {
        var cookedReceitas: [CKRecord] = []
        for receita in recepie where receita.value(forKey: "Categoria") as? String == "Cozidos" {
            cookedReceitas.append(receita)
        }
        return cookedReceitas
    }
    
    func getFriedReceitas() -> [CKRecord] {
        var friedReceitas: [CKRecord] = []
        for receita in recepie where receita.value(forKey: "Categoria") as? String == "Fritos" {
            friedReceitas.append(receita)
        }
        return friedReceitas
    }
    
    func getDrinkReceitas() -> [CKRecord] {
        var drinkReceitas: [CKRecord] = []
        for receita in recepie where receita.value(forKey: "Categoria") as? String == "Bebidas" {
            drinkReceitas.append(receita)
        }
        return drinkReceitas
    }

    // MARK: - Construction table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recepie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "IDMenuCell") as? CardsMenuTableViewCell {
            for receita in filterRenevue {
                let url = (receita["ImagemMenu"] as! CKAsset).fileURL
                if let data = try? Data(contentsOf: url!), let image = UIImage(data: data) {
                cell.imageRecipeCardMenu?.image = image
                    
                let name = filterRenevue[indexPath.row].value(forKey: "NomeDaReceita") as! String
                cell.labelNameRecipeCardMenu?.text = name
                
                let time = filterRenevue[indexPath.row].value(forKey: "TempoDePreparo") as! String
                cell.labelTimeRecipeCardMenu?.text = time

                let serves = filterRenevue[indexPath.row].value(forKey: "QuantidadeDePessoasQueServe") as! String
                cell.labelPeopleRecipeCardMenu?.text = serves
                    }
                cell.imageRecipeCardMenu.layer.cornerRadius = 15
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let recepie = filterRenevue[indexPath.row]
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RecipePage") as? RecepieViewController {
            
            viewController.revenue = recepie
            
            if let navigator = navigationController {
                navigator.pushViewController(viewController, animated: true)
            }
        }
    }
}
