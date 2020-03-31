//
//  TeFiti.swift
//  Mulan
//
//  Created by Nathalia Melare on 14/05/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import Foundation
import UIKit

struct Dica: Codable {
    var palavraschave: [String]
    var dicas: String
    var nomedaimagem: String
    var nomeDaDica: String
    var nomedaimagem2: String
}

class InternDica: NSObject {
    static func getAllTutorials() -> [Dica] {
        var tutoriais: [Dica] = []
        do {
            if let path = Bundle.main.path(forResource: "TutoriaisPortugues", ofType: "json", inDirectory: nil)
            {
                let url = URL(fileURLWithPath: path)
                let tutorialData = try Data(contentsOf: url)
                tutoriais = try JSONDecoder().decode([Dica].self, from: tutorialData)
                return tutoriais
            }
        } catch {
            print("Erro ao carregar Json dos tutoriais")
        }
        return tutoriais
}
}
