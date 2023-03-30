//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Danjuma Nasiru on 05/02/2023.
//
import CoreData
import SwiftUI



//basic way for dynamic filtering
//struct FilteredList: View {
//
//    @FetchRequest var fetchRequest: FetchedResults<Singer>
//
//    var body: some View {
//
//        List(fetchRequest, id: \.self) { singer in
//                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
//            }
//
//    }
//
//    init(filter: String) {
//        _fetchRequest = FetchRequest<Singer>(sortDescriptors: [], predicate: NSPredicate(format: "lastName BEGINSWITH %@", filter))
//    }
//}



//advanced way
struct FilteredList<T: NSManagedObject, Content: View>: View {

    @FetchRequest var fetchRequest: FetchedResults<T>
    let content : (T) -> Content

    var body: some View {

        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }.listStyle(.plain)

    }

    init(sortDesc: [SortDescriptor<T>], filterKey: String, filterValue: String, filterPredicate: Predicate, @ViewBuilder content: @escaping (T) -> Content) {
        if filterValue.isEmpty{
            _fetchRequest = FetchRequest<T>(sortDescriptors: sortDesc)
        }else{
            _fetchRequest = FetchRequest<T>(sortDescriptors: sortDesc, predicate: NSPredicate(format: "%K \(filterPredicate.rawValue.uppercased())[c] %@", filterKey, filterValue))
        }
        
        self.content = content
    }
}

enum Predicate : String{
    case beginsWith
    case contains
}
