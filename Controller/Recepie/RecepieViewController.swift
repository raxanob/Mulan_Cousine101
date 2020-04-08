//
//  ReceitaViewController.swift
//  Cuisine101
//
//  Created by Nathalia Melare on 15/01/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class RecepieViewController: UIViewController {

    struct Ingredient {
        var name: String
        var image: UIImage
        var dose: String
    }
    
    var revenue: CKRecord!
    var data: [Ingredient] = []
    lazy var settingsModal = SettingsModal(recipe: revenue)
    
    @IBOutlet weak var testTutorialButton: UIButton!
    @IBOutlet weak var pratoImagem: UIImageView!
    @IBAction func testModalButton(_ sender: Any) {
        handleSettings()
    }
    
    @IBOutlet weak var viewOfRecepie: UIView!
    @IBOutlet weak var titleOfRecepie: UILabel!
    @IBOutlet weak var serverOfRecepieLabel: UILabel!
    @IBOutlet weak var timeOfRecepieLabel: UILabel!
    @IBOutlet weak var textMethodOfPreparation: UITextView!
    @IBOutlet weak var labelHeaderIngredients: UILabel!
    @IBOutlet weak var labelHeaderMethodOfPreparation: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let url = (revenue["ImagemPaginaReceita"] as! CKAsset).fileURL
        if let data = try? Data(contentsOf: url!), let image = UIImage(data: data) {
        pratoImagem.image = image
        }
        titleOfRecepie.text = revenue.value(forKey: "NomeDaReceita") as? String
        serverOfRecepieLabel.text = revenue.value(forKey: "QuantidadeDePessoasQueServe") as? String
        timeOfRecepieLabel.text = revenue.value(forKey: "TempoDePreparo") as? String
        textMethodOfPreparation.text = revenue.value(forKey: "ModoDePreparo") as? String
        textMethodOfPreparation.isEditable = false
        
        viewOfRecepie.layer.cornerRadius = 20
        view.addSubview(viewOfRecepie)
        
        testTutorialButton.layer.cornerRadius = 10
        testTutorialButton.setTitle(revenue.value(forKey: "NomeDaDica") as? String, for: .normal)
        
        self.navigationController!.navigationBar.topItem?.title = "";
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .none
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.topAnchor.constraint(equalTo: labelHeaderIngredients.bottomAnchor, constant: 8).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nomesIngredientes = revenue["NomeIngredientes"] as! [String]
        let quantidadesIngredientes = revenue["QuantidadeIngredientes"] as! [String]
        let imagensIngredientes = revenue["ImagensIngredientes"] as! [CKAsset]
        
        for i in 0...nomesIngredientes.count {
            let url = (imagensIngredientes[i]).fileURL
            if let ndata = try? Data(contentsOf: url!), let image = UIImage(data: ndata) {
            data.append(Ingredient.init(name: nomesIngredientes[i], image: image, dose: quantidadesIngredientes[i]))
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    func handleSettings() {
        settingsModal.handleMore()
        settingsModal.collectionViewSetUp()
        settingsModal.firstAnimationModal()
    }
    
    fileprivate var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(IngredientsCollectionViewCell.self, forCellWithReuseIdentifier: "cellRecepie")
        return cv
    }()
}
