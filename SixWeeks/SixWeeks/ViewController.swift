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
    
    var entity = Entity?()
    var entities = [Entity]()
    var entitiesArray = [Entity]()
    let pair = "->"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func randomizeButtonTapped(sender: AnyObject) {
        var indexArray = Array(entities.indices)
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
        let permutationGenerator = PermutationGenerator(elements: entities, indices: AnySequence(randomizer))
        let randomized = Array(permutationGenerator)
        
        var entitiesLabel = ""
        for entities in randomized {
            entitiesLabel += entities.name + ", "
        }
//        let paired = [pair].joinWithSeperator(randomized.map{ [ $0 ] } )//map($0..< $0*randomized.count - 1) {$0 % 2 == 0 ? randomized[$0/2] : pair}
        labelField.text = entitiesLabel
    }
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        if let entity = entity {
            entity.name = self.textField.text!
        } else {
            let newEntity = Entity(name: self.textField.text!)
            EntityController.sharedController.addEntity(newEntity)
            self.entities.append(newEntity)
//            self.entity = newEntity
        }
//        let entityForIndex = self.entities[index]
//        self.entitiesArray.append(entityForIndex)
        
        var entitiesLabel = ""
        for entity in entities {
            entitiesLabel += entity.name + "  "
        }
//        let paired2 = [pair].joinWithSeparator(entities.map{[$0]})
//        let paired = entities.joinWithSeparator(pair)
//        let array = entitiesLabel.characters.split{$0 == " "}.map(String.init)
//        let paired = [pair].map(0..< 2*randomized.count - 1) {$0 % 2 == 0 ? randomized[$0/2] : pair}
//
//        
//        print(array)
        
        labelField.text = entitiesLabel
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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


