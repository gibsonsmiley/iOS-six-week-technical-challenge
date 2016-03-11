//
//  Entity.swift
//  SixWeeks
//
//  Created by Gibson Smiley on 3/11/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import Foundation

class Entity: Equatable {
    
    private let kName = "name"
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    init?(dictionary: Dictionary<String, AnyObject>) {
        guard let name = dictionary[kName] as? String else { self.name = ""; return nil }
        self.name = name
    }
    
    func dictionaryCopy() -> Dictionary<String, AnyObject> {
        let dictionary = [ kName: self.name]
        return dictionary
    }
}

func ==(lhs: Entity, rhs: Entity) -> Bool {
    return lhs.name == rhs.name
}