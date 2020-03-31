//
//  ListadeIngredientes1+CoreDataProperties.swift
//  Mulan
//
//  Created by Nathalia Melare on 13/05/19.
//  Copyright © 2019 Nathalia Melare. All rights reserved.
//
//

import Foundation
import CoreData


extension ListadeIngredientes1 {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListadeIngredientes1> {
        return NSFetchRequest<ListadeIngredientes1>(entityName: "ListadeIngredientes1")
    }

    @NSManaged public var nome: String?
    @NSManaged public var quantidade: String?
    @NSManaged public var lalala: String?

}
