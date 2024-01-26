import Foundation
import CoreData

class DataController: ObservableObject {
    //Detect database
    let container = NSPersistentContainer(name: "TicketModel")
    
    //Init or Open database
    init (){
        container.loadPersistentStores { desc, error in
            if let error = error{
                print("Failet to load data: \(error.localizedDescription)")
            }
        }
    }
    
    //Save content in DataBase
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data saved !!! Successfully")
        }catch{
            print("We could not save the data...")
        }
    }
    
    //Add new content in Database
    func addTicket(address:String, id:UUID, name:String, number:String, schedule:Date, context:NSManagedObjectContext){
        let ticket = Ticketts(context: context)
        ticket.id = id
        ticket.schedule = schedule
        ticket.address = address
        ticket.name = name
        ticket.number = number
        
        save(context: context)
    }
    
    //Edit content in Database
    func editTicket (ticket:Ticketts , address:String, id:UUID, name:String, number:String, schedule:Date, context:NSManagedObjectContext){
        ticket.id = id
        ticket.schedule = schedule
        ticket.address = address
        ticket.name = name
        
        save(context: context)
    }
}
