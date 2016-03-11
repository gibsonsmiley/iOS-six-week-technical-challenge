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
    var entities: [Entity] = []
    var entitiesArray: [Entity] = []
    let pair = "->"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        labelField.text = String(EntityController.sharedController.entities)
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
        for entities in randomized {
            entitiesLabel += entities.name + " "
        }
        labelField.text = entitiesLabel
    }
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        if let entity = entity {
            entity.name = self.textField.text!
        } else {
            let newEntity = Entity(name: self.textField.text!)
            EntityController.sharedController.addEntity(newEntity)
            self.entities.append(newEntity)
        }
        
        var entitiesLabel = ""
        for entity in entities {
            entitiesLabel += entity.name + "  "
        }
        labelField.text = entitiesLabel
        EntityController.sharedController.saveToPersistantStorage()
        print(entitiesLabel)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        }
    @IBAction func clearButtonTapped(sender: AnyObject) {
        EntityController.sharedController.entities = []
    }
    
    @IBAction func deleteButtonTapped(sender: AnyObject) {
        if textField.text != nil {
            
        }
        EntityController.sharedController.deleteEntity(<#T##entity: Entity##Entity#>)
    }
}

extension String {
    var pairs: [String] {
        var result: [String] = []
        let chars = Array(characters)
        for index in 0.stride(to: chars.count, by: 2) {
            result.append(String(chars[index..<min(index+2, chars.count)]))
        }
        return result
    }
}


