//
//  ReceitaViewController.swift
//  Cuisine101
//
//  Created by Nathalia Melare on 15/01/20.
//  Copyright © 2020 Nathalia Melare. All rights reserved.
//

import Foundation
import UIKit

class RecepieViewController: UIViewController {
    
    struct Ingredient {
        var name: String
        var image: UIImage
        var dose: String
    }
    
    var renevue: Receita!
    var data: [Ingredient] = []
    lazy var settingsModal = SettingsModal(recipe: renevue)
    
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
        pratoImagem.image = UIImage(named:renevue.nomeDaImagemPaginaReceita)
        titleOfRecepie.text = renevue.nomeDaReceita
        serverOfRecepieLabel.text = renevue.quantasPessoasServe
        timeOfRecepieLabel.text = renevue.tempoDePreparo
        textMethodOfPreparation.text = renevue.modoDePreparo.joined(separator: "\n")
        textMethodOfPreparation.isEditable = false
        
        viewOfRecepie.layer.cornerRadius = 20
        view.addSubview(viewOfRecepie)
        
        testTutorialButton.layer.cornerRadius = 10
        testTutorialButton.setTitle(renevue.nomeDaDica, for: .normal)
        
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
