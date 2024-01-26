//
//  NewTicket.swift
//  ISUCorp
//
//  Created by BeMillionaire on 1/23/24.
//

import SwiftUI

struct NewTicket: View {
    @Environment(\.managedObjectContext) var moc //moc = managedObjectContext
    @Environment(\.dismiss) var dismiss
    @State private var address = ""
    @State private var id = UUID()
    @State private var name = ""
    @State private var number = ""
    @State private var schedule = Date()
    var body: some View {
        Form{
            Section{
                TextField("address...", text: $address)
                TextField("name...", text: $name)
                TextField("number of ticket...", text: $number)
                DatePicker("schedule...", selection: $schedule).foregroundColor(.gray)
            }header: {
                HStack{
                    Image(systemName: "plus.viewfinder").foregroundColor(.green)
                    Text("Add new ticket").foregroundColor(.green)
                    Spacer()
                    //Logic for not accepting Empty fields
                    if !self.address.isEmpty && !self.name.isEmpty && !self.number.isEmpty {
                        Button("Add"){
                                DataController().addTicket(address: address, id: id, name: name, number: number, schedule: schedule, context: moc)
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

struct NewTicket_Previews: PreviewProvider {
    static var previews: some View {
        NewTicket()
    }
}
