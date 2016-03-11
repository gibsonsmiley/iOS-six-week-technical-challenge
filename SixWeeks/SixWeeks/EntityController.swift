//
//  EntityController.swift
//  SixWeeks
//
//  Created by Gibson Smiley on 3/11/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import Foundation

class EntityController {
    
    private let kEntities = "entities"
    var entities = [Entity]()
    static let sharedController = EntityController()
    
    init() {
        self.entities = []
        self.loadFromPersistantStorage()
    }
    
    func addEntity(entity: Entity) {
        entities.append(entity)
        self.saveToPersistantStorage()
    }
    
    func deleteEntity(entity: Entity) {
        if let entityIndex = entities.indexOf(entity) {
            entities.removeAtIndex(entityIndex)
        }
    }
    
    func updateEntity() {
        
    }
    
    func loadFromPersistantStorage() {
        let entityDictionaryFromDefaults = NSUserDefaults.standardUserDefaults().objectForKey(kEntities) as? [Dictionary<String, AnyObject>]
        if let entityDictionaries = entityDictionaryFromDefaults {
            self.entities = entityDictionaries.map({Entity(dictionary: $0)!})
        }
    }
    
    func saveToPersistantStorage() {
        let entityDictionaries = self.entities.map({$0.dictionaryCopy()})
        NSUserDefaults.standardUserDefaults().setObject(entityDictionaries, forKey: kEntities)
    }
}