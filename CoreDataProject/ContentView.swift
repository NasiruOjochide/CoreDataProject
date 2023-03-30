//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Danjuma Nasiru on 04/02/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    
    @State private var showAddCountriesBtn = true
    
    @State private var filterValue = ""
    @State private var filterPredicate = Predicate.contains
    var filterKeyOptions = ["Countries", "Continents"]
    @State private var filterKeyChoice = "Countries"
    var filterkey : String{
        if filterKeyChoice == "Countries"{
            return "fullName"
        }else{
            return "continent"
        }
    }
    var sortDesc = [SortDescriptor<Country>(\.fullName)]
    //    var wiz : Wizard{
    //        let wizz = Wizard(context: moc)
    //        wizz.name = "kofi"
    //        return wizz
    //    }
    @FetchRequest(sortDescriptors: []) var wizards : FetchedResults<Wizard>
    
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "universe == 'Star Wars'")) var ships : FetchedResults<Ship>
    
    
    //or
    //NSPredicate(format: "universe == %@", "Star Wars"))
    //%@‘ means “insert some data here”, and allows us to provide that data as a parameter to the predicate rather than inline.
    
    
    //or
    //NSPredicate(format: "name < %@", "F"))
    
    
    //we could use an IN predicate to check whether the universe is one of three options from an array, like this:
    //NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
    
    
    //We can also use predicates to examine part of a string, using operators such as BEGINSWITH and CONTAINS. For example, this will return all ships that start with a capital E:
    //NSPredicate(format: "name BEGINSWITH %@", "E"))
    
    
    //That predicate is case-sensitive; if you want to ignore case you need to modify it to this:
    //NSPredicate(format: "name BEGINSWITH[c] %@", "e"))
    //CONTAINS[c] works similarly, except rather than starting with your substring it can be anywhere inside the attribute.
    
    
    //you can flip predicates around using NOT, to get the inverse of their regular behavior. For example, this finds all ships that don’t start with an E:
    //NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e"))
    
    
    //If you need more complicated predicates, join them using AND to build up as much precision as you need, or add an import for Core Data and take a look at NSCompoundPredicate – it lets you build one predicate out of several smaller ones.
    
    var body: some View {
        
        VStack{
            
            
            
            NavigationView{
                VStack{
                    
                    VStack(alignment: .leading){
                        Text("Choose search filter")
                        Picker("choose Filter Option", selection: $filterKeyChoice, content: {
                            ForEach(filterKeyOptions, id: \.self){
                                Text($0)
                            }
                        }).pickerStyle(.segmented)
                        
                    }.padding()
                    TextField("Search here", text: $filterValue)
                        .padding(.horizontal)
                    
                    FilteredList(sortDesc: sortDesc, filterKey: filterkey, filterValue: filterValue, filterPredicate: filterPredicate, content: {(country: Country) in
                        HStack(alignment: .lastTextBaseline){
                            VStack(alignment: .leading){
                                Text(country.wrappedShortName).font(.caption)
                                Text(country.wrappedFullName)
                            }
                            Spacer()
                            Text(country.wrappedContinent)
                        }
                    })
                    
                    if showAddCountriesBtn{
                        Button("Add Countries"){
                            addCountries()
                        }
                    }else{
                        Button("Add Countries"){
                            addCountries()
                        }.hidden()
                    }
                    
                }
                .navigationTitle("Countries")
                .navigationBarTitleDisplayMode(.inline)
            }
            
            
            
            
            
            
            //            List {
            //                ForEach(countries, id: \.self) { country in
            //                    Section(country.wrappedFullName) {
            //                        ForEach(country.candyArray, id: \.self) { candy in
            //                            Text(candy.wrappedName)
            //                        }
            //                    }
            //                }
            //            }
            //
            //            Button("Add") {
            //                let candy1 = Candy(context: moc)
            //                candy1.name = "Mars"
            //                candy1.origin = Country(context: moc)
            //                candy1.origin?.shortName = "UK"
            //                candy1.origin?.fullName = "United Kingdom"
            //
            //                let candy2 = Candy(context: moc)
            //                candy2.name = "KitKat"
            //                candy2.origin = Country(context: moc)
            //                candy2.origin?.shortName = "UK"
            //                candy2.origin?.fullName = "United Kingdom"
            //
            //                let candy3 = Candy(context: moc)
            //                candy3.name = "Twix"
            //                candy3.origin = Country(context: moc)
            //                candy3.origin?.shortName = "UK"
            //                candy3.origin?.fullName = "United Kingdom"
            //
            //                let candy4 = Candy(context: moc)
            //                candy4.name = "Toblerone"
            //                candy4.origin = Country(context: moc)
            //                candy4.origin?.shortName = "CH"
            //                candy4.origin?.fullName = "Switzerland"
            //
            //                try? moc.save()
            //            }
            
            
            
            
            
            //                        VStack {
            //
            //                            FilteredList(sortDesc: sortDesc, filterKey: "lastName", filterValue: filterValue, filterPredicate: .beginsWith){(singer : Singer) in
            //                                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            //                            }
            //
            //                            Button("Add Examples") {
            //                                let taylor = Singer(context: moc)
            //                                taylor.firstName = "Taylor"
            //                                taylor.lastName = "Swift"
            //
            //                                let ed = Singer(context: moc)
            //                                ed.firstName = "Ed"
            //                                ed.lastName = "Sheeran"
            //
            //                                let adele = Singer(context: moc)
            //                                adele.firstName = "Adele"
            //                                adele.lastName = "Adkins"
            //
            //
            //                                try? moc.save()
            //                            }
            //
            //                            Button("Show A") {
            //                                lastNameFilter = "A"
            //                            }
            //
            //                            Button("Show S") {
            //                                lastNameFilter = "S"
            //                            }
            //                        }
            
            
            
            
            
            
            //            VStack{
            //                List(ships, id: \.self){ship in
            //                    Text(ship.name ?? "unknown name")
            //                }
            //
            //                Button("Add Examples"){
            //                    let ship1 = Ship(context: moc)
            //                    ship1.name = "Enterprise"
            //                    ship1.universe = "star trek"
            //
            //                    let ship2 = Ship(context: moc)
            //                    ship2.name = "Defiant"
            //                    ship2.universe = "Star Trek"
            //
            //                    let ship3 = Ship(context: moc)
            //                    ship3.name = "Millennium Falcon"
            //                    ship3.universe = "Star Wars"
            //
            //                    let ship4 = Ship(context: moc)
            //                    ship4.name = "Executor"
            //                    ship4.universe = "Star Wars"
            //
            //                    try? moc.save()
            //                }
            //            }
            
            
            
            
            //            List(wizards, id: \.self){wizard in
            //                Text(wizard.name ?? "Unknown")
            //            }
            
            //Text(wiz.name ?? "kofff")
            
            //            Button("add"){
            //                let wizard = Wizard(context: moc)
            //                wizard.name = "Harry Potter"
            //            }
            //
            //            Button("save"){
            //                do{
            //                    //this won't work naturally bcos we have set our model to have a constraint for the name property meaning it must be unique, no two wizard objects can have the same name property. we fix it using mergePolicy in dataController
            //                    try moc.save()
            //                }catch{
            //                    print(error.localizedDescription)
            //                }
            //            }
            
            
            
            //        Button("Save"){
            //            //it checks if any of the objects managed by this managedObject has changes. we can also check if a particular object has changes
            //            if moc.hasChanges{
            //                try? moc.save()
            //            }
            //        }
        }
    }
    
    func addCountries(){
        let country1 = Country(context: moc)
        country1.continent = "Asia"
        country1.fullName = "India"
        country1.shortName = "IND"
        
        let country2 = Country(context: moc)
        country2.continent = "Asia"
        country2.fullName = "Afghanistan"
        country2.shortName = "AFG"
        
        let country3 = Country(context: moc)
        country3.continent = "Africa"
        country3.fullName = "Algeria"
        country3.shortName = "DZA"
        
        let country4 = Country(context: moc)
        country4.continent = "South America"
        country4.fullName = "Argentina"
        country4.shortName = "ARG"
        
        let country5 = Country(context: moc)
        country5.continent = "South America"
        country5.fullName = "Brasil"
        country5.shortName = "BRA"
        
        let country6 = Country(context: moc)
        country6.continent = "Asia"
        country6.fullName = "Cambodia"
        country6.shortName = "KHM"
        
        let country7 = Country(context: moc)
        country7.continent = "Asia"
        country7.fullName = "Macao"
        country7.shortName = "MAC"
        
        let country8 = Country(context: moc)
        country8.continent = "Africa"
        country8.fullName = "Côte d'Ivoire"
        country8.shortName = "CIV"
        
        let country9 = Country(context: moc)
        country9.continent = "Europe"
        country9.fullName = "Denmark"
        country9.shortName = "DNK"
        
        let country10 = Country(context: moc)
        country10.continent = "North America"
        country10.fullName = "Dominican Republic"
        country10.shortName = "DOM"
        
        let country11 = Country(context: moc)
        country11.continent = "South America"
        country11.fullName = "Ecuador"
        country11.shortName = "ECU"
        
        let country12 = Country(context: moc)
        country12.continent = "North America"
        country12.fullName = "El Salvador"
        country12.shortName = "SLV"
        
        let country13 = Country(context: moc)
        country13.continent = "Africa"
        country13.fullName = "Ethiopia"
        country13.shortName = "ETH"
        
        let country14 = Country(context: moc)
        country14.continent = "Europe"
        country14.fullName = "Faroe Islands"
        country14.shortName = "FRO"
        
        let country15 = Country(context: moc)
        country15.continent = "Europe"
        country15.fullName = "Greece"
        country15.shortName = "GRC"
        
        let country16 = Country(context: moc)
        country16.continent = "North America"
        country16.fullName = "Greenland"
        country16.shortName = "GRL"
        
        let country17 = Country(context: moc)
        country17.continent = "North America"
        country17.fullName = "Haiti"
        country17.shortName = "HTI"
        
        let country18 = Country(context: moc)
        country18.continent = "Asia"
        country18.fullName = "Kyrgyzstan"
        country18.shortName = "KGZ"
        
        let country19 = Country(context: moc)
        country19.continent = "Africa"
        country19.fullName = "Nigeria"
        country19.shortName = "NGA"
        
        let country20 = Country(context: moc)
        country20.continent = "Australia"
        country20.fullName = "Samoa"
        country20.shortName = "WSM"
        
        let country21 = Country(context: moc)
        country21.continent = "Europe"
        country21.fullName = "United Kingdom"
        country21.shortName = "GBR"
        
        let country22 = Country(context: moc)
        country22.continent = "North America"
        country22.fullName = "United States of America"
        country22.shortName = "USA"
        
        let country23 = Country(context: moc)
        country23.continent = "Asia"
        country23.fullName = "Vietnam"
        country23.shortName = "VNM"
        
        let country24 = Country(context: moc)
        country24.continent = "Africa"
        country24.fullName = "Zimbabwe"
        country24.shortName = "ZWE"
        
        let country25 = Country(context: moc)
        country25.continent = "North America"
        country25.fullName = "Canada"
        country25.shortName = "CAN"
        
        let country26 = Country(context: moc)
        country26.continent = "Africa"
        country26.fullName = "Niger"
        country26.shortName = "NER"
        
        let country27 = Country(context: moc)
        country27.continent = "North America"
        country27.fullName = "Mexico"
        country27.shortName = "MEX"
        
        let country28 = Country(context: moc)
        country28.continent = "Europe"
        country28.fullName = "Portugal"
        country28.shortName = "PRT"
        
        let country29 = Country(context: moc)
        country29.continent = "Australia"
        country29.fullName = "Australia"
        country29.shortName = "AUS"
        
        let country30 = Country(context: moc)
        country30.continent = "Australia"
        country30.fullName = "Australia"
        country30.shortName = "AUS"
        
        
//        moc.delete(countries.first(where: {country in
//            country.fullName == "Switzerland"
//        })!)
//
//        moc.delete(countries.first(where: {country in
//            country.continent == nil
//        })!)
        
        try? moc.save()
        
        showAddCountriesBtn = false
    }
    
    init(){
        UITableView.appearance().backgroundColor = UIColor.clear
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
