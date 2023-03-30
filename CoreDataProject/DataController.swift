//
//  DataController.swift
//  CoreDataProject
//
//  Created by Danjuma Nasiru on 04/02/2023.
//

import Foundation
import CoreData

class DataController : ObservableObject{
    
    var container = NSPersistentContainer(name: "CoredataProject")
    
    init(){
        try? container.loadPersistentStores(completionHandler: { description, error in
            if let error = error{
                print("Core data failed to load: \(error.localizedDescription)")
                return
            }
            //this will help us resolve any conflicts our objects might have. In our case when 2 or more Wizaed objects have been created with the same name property, this helps us choose 1 and just discards the rest
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        })
    }
}
