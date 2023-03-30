//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Danjuma Nasiru on 04/02/2023.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }
    

    //NOTE: these are not real properties and @NSManaged is not a property wrapper.
    //Also making these values not optional doesn't mean they'll always need to have a value. you could still create an instance of this class without providing those values and coredata wont complain bcause it loads things lazily. It would only know there's no value when trying to read that particular value
    @NSManaged public var title: String?
    @NSManaged public var director: String?
    @NSManaged public var year: Int16
    
    //this way instead of providing defaults everwhere we read title, we just read wrapped title instead and its default has already been handled here once and for all
    public var wrappedTitle: String{
        title ?? "Unknown Title"
    }

}

extension Movie : Identifiable {

}
