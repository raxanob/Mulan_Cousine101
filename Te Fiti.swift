//
//  Te Fiti.swift
//  Mulan
//
//  Created by Nathalia Melare on 13/05/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//

import Foundation

typealias Receita = [TEFITIBANCO]

struct TEFITIBANCO: Codable {
    public var nome: String
    public var tempo: String
    public var imagem: String
    public var passoApasso: String
    public var lalala: String
}
