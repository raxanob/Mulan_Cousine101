//
//  Maui.swift
//  Mulan
//
//  Created by Nathalia Melare on 13/05/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import Foundation
import UIKit

struct Receita: Codable {
        var ingredientes: [String]
        var imagensDosIngredientes: [String]
        var quantidade: [String]
        var modoDePreparo: [String]
        var nomeDaReceita: String
        var nomeDaImagemMenu: String
        var nomeDaImagemPaginaReceita: String
        var tempoDePreparo: String
        var quantasPessoasServe: String
        var categoria: String
        var nomeDaDica: String
        var dicas: String
    }

class InternReceita: NSObject {
    static func getAllRecepies() -> [Receita] {
        var receitas: [Receita] = []
        do {
            if let path = Bundle.main.path(forResource: NSLocalizedString("arquivoJson", comment: "nomeDoArquivoJson"), ofType: "json", inDirectory: nil)
            {
                let url = URL(fileURLWithPath: path)
                let recepiesData = try Data(contentsOf: url)
                receitas = try JSONDecoder().decode([Receita].self, from: recepiesData)
                return receitas
            }
        } catch {
            print("Erro ao carregar Json das receitas")
        }
        return receitas
    }
    }
