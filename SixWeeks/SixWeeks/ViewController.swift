//
//  ViewController.swift
//  SixWeeks
//
//  Created by Gibson Smiley on 3/11/16.
//  Copyright © 2016 Gibson Smiley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelField: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var entity: Entity?
    var entities: [Entity] {
        return EntityController.sharedController.entities
    }
    var entitiesArray: [Entity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let entities = EntityController.sharedController.entities
        var entitiesLabel = ""
        for var i=0; i<entities.count; i++ {
            let entity = entities[i]
            if i == (entities.count - 1) {
                entitiesLabel += entity.name
            } else if i%2 == 0 {
                entitiesLabel += entity.name + " : "
            } else {
                entitiesLabel += entity.name + "\n"
            }
        }
        labelField.text = entitiesLabel
    }
    
    @IBAction func randomizeButtonTapped(sender: AnyObject) {
        var indexArray = Array(EntityController.sharedController.entities.indices)
        var index = indexArray.endIndex
        
        let randomizer: AnyGenerator<Int> = anyGenerator {
            if index == indexArray.startIndex {  return nil }
            index = index.advancedBy(-1, limit: indexArray.startIndex)
            let rando = Int(arc4random_uniform(UInt32(index)))
            if rando != index {
                swap(&indexArray[rando], &indexArray[index])
            }
            return indexArray[index]
        }
        
        let permutationGenerator = PermutationGenerator(elements: EntityController.sharedController.entities, indices: AnySequence(randomizer))
        let randomized = Array(permutationGenerator)
        
        var entitiesLabel = ""
        for var i=0; i<randomized.count; i++ {
            let entity = randomized[i]
            if i == (randomized.count - 1) {
                entitiesLabel += entity.name
            } else if i%2 == 0 {
                entitiesLabel += entity.name + " : "
            } else {
                entitiesLabel += entity.name + "\n"
            }
        }
        labelField.text = entitiesLabel
    }
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        if let entity = entity {
            entity.name = self.textField.text!
        } else {
            let newEntity = Entity(name: self.textField.text!)
            EntityController.sharedController.addEntity(newEntity)
        }

        var entitiesLabel = ""
        for var i=0; i<entities.count; i++ {
            let entity = entities[i]
            if i == (entities.count - 1) {
                entitiesLabel += entity.name
            } else if i%2 == 0 {
                entitiesLabel += entity.name + " : "
            } else {
                entitiesLabel += entity.name + "\n"
            }
        }
        labelField.text = entitiesLabel
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        }
    
    @IBAction func clearButtonTapped(sender: AnyObject) {
        labelField.text = ""
        EntityController.sharedController.entities.removeAll()
        EntityController.sharedController.saveToPersistantStorage()
    }
}

