//
//  EditTicket.swift
//  ISUCorp
//
//  Created by BeMillionaire on 1/23/24.
//

import SwiftUI

struct EditTicket: View {
    @Environment(\.managedObjectContext) var moc //moc = managedObjectContext
    @Environment(\.dismiss) var dismiss
    @State private var address = ""
    @State private var id = UUID()
    @State private var name = ""
    @State private var number = ""
    @State private var schedule = Date()
    
    var ticketts: FetchedResults<Ticketts>.Element
    
    var body: some View {
        Form{
            Section{
                TextField("address...", text: $address)
                    .onAppear{
                        address = ticketts.address ?? ""
                    }
                TextField("name...", text: $name)
                    .onAppear{
                        name = ticketts.name ?? ""
                    }
                TextField("number of ticket...", text: $number)
                    .onAppear{
                        number = ticketts.number ?? ""
                    }
                DatePicker("schedule...", selection: $schedule).foregroundColor(.gray)
            }header: {
                HStack{
                    Image(systemName: "square.and.pencil").foregroundColor(.green)
                    Text("Edit this ticket").foregroundColor(.green)
                    Spacer()
                    //Logic for not accepting empty fields
                    if !self.address.isEmpty && !self.name.isEmpty && !self.number.isEmpty {
                        Button("Save"){
                            DataController().editTicket(ticket: ticketts, address: address, id: id, name: name, number: number, schedule: schedule, context: moc)
                            dismiss()
                        }.buttonStyle(.borderedProminent)
                            .tint(.green.opacity(0.7))
                    }else {
                        Text("all inputs are required").foregroundColor(.orange.opacity(0.7)).bold()
                    }
                    
                }
            }
            
        }
    }
}

//struct EditTicket_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTicket(ticketts : ticketts)
//    }
//}
