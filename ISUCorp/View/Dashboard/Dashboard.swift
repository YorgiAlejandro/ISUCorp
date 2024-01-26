//
//  Dashboard.swift
//  ISUCorp
//
//  Created by BeMillionaire on 1/22/24.
//

import SwiftUI
import EventKit

struct Dashboard: View {
    //SwipeActions properties
    @State var isAddSheetPresented: Bool = false
    @State var isEditSheetPresented: Bool = false
    
    //Buttons properties
    @State var ticketEditId: Int = 0
    @State var ticketDetailId: Int = 0
    @State var showTicketDetail: Bool = false
    @State var isMapPresented: Bool = false
    
    //DataBase properties
    @Environment(\.managedObjectContext) var moc //moc = managedObjectContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Ticketts.schedule, ascending: true),NSSortDescriptor(keyPath: \Ticketts.number, ascending: true),NSSortDescriptor(keyPath: \Ticketts.name, ascending: true),NSSortDescriptor(keyPath: \Ticketts.id, ascending: true),NSSortDescriptor(keyPath: \Ticketts.address, ascending: true)],
        animation: .default)
    //Array of ticketts on DataBase
    private var ticketts: FetchedResults<Ticketts>
    
    //View Refresh
    @State private var refreshID = UUID()
    
    //Calendar properties
    @State private var showEventEditViewController = false
    @State private var event: EKEvent?
    @State private var store = EKEventStore()
    
    var body: some View {
        VStack{
            //NavBar
            HStack{
                HStack{
                    Button {
                        showEventEditViewController = true
                    } label: {
                        VStack{
                            Image(systemName:"calendar.badge.plus")
                            Text("Calendar")
                        }
                    }
                    .foregroundColor(.green.opacity(0.7))
                    .padding(10)
                    .font(.title2)
                    Button {
                        //Do anything
                    } label: {
                        VStack {
                            Image(systemName: "arrow.triangle.2.circlepath").bold()
                            Text("Sync")
                        }
                    }
                    .foregroundColor(.green.opacity(0.7))
                    .padding(10)
                    .font(.title2)
                }
                Spacer()
                HStack{
                    Image("LoginImage")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 90)
                    Text("|")
                        .font(.system(size: 50))
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                    Text("DASHBOARD")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                Spacer()
                HStack{
                    Button {
                        isAddSheetPresented = true
                    } label: {
                        VStack{
                            Image(systemName: "plus").bold()
                            Text("New Ticket")
                        }
                    }
                    .foregroundColor(.green.opacity(0.7))
                    .padding(10)
                    .font(.title2)
                    Button {
                        //
                    } label: {
                        VStack{
                            Image(systemName: "line.horizontal.3")
                                .bold()
                            Text("Menu")
                        }
                    }.contextMenu {
                        Button {
                            ticketDetailId = ticketts.count - 1
                            refreshID = UUID()
                            showTicketDetail = true
                        } label: {
                            Label("Work Ticket", systemImage: "list.clipboard.fill").foregroundColor(.green)
                        }.buttonStyle(.borderedProminent).tint(.green)
                        Button {
                            isMapPresented = true
                        } label: {
                            Label("Get Directions", systemImage: "location.square.fill")
                        }.buttonStyle(.borderedProminent).tint(.green)
                    }
                    .foregroundColor(.green.opacity(0.7))
                    .padding(10)
                    .font(.title2)
                }
                
            }
            //List of Tickets
            Form {
                ForEach(ticketts, id: \.id){ element in
                    HStack{
                        VStack{
                            Text(element.schedule ?? Date(), style: .time)
                                .font(.title)
                                .foregroundColor(.black.opacity(0.6))
                            Text("\(element.schedule ?? Date(), style: .date )")
                                .fontWeight(.light)
                                .font(.title3)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("Ticket #\(element.number ?? "0")")
                                .foregroundColor(.gray)
                                .font(.title3)
                                .padding(.top, 20)
                        }
                        Divider().padding(15)
                        VStack(alignment: .leading){
                            Text(element.name ?? "")
                                .font(.title)
                                .foregroundColor(.black.opacity(0.6))
                            Text(element.address ?? "")
                                .fontWeight(.light)
                                .font(.title3)
                                .foregroundColor(.gray)
                                .frame(width: 250)
                            Spacer()
                        }
                        Spacer()
                        Button("View Ticket") {
                            ticketDetailId = ticketts.firstIndex(of: element) ?? 0
                            refreshID = UUID()
                            showTicketDetail = true
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 15)
                        .background(Color.green.opacity(1.0))
                        .foregroundColor(.white)
                        .font(.title2)
                        .bold()
                        .cornerRadius(15)
                        .frame(width: 200)
                    }
                    .padding(25)
                    .swipeActions(edge: .leading){ //Edit Button
                        Button{
                            if let index = ticketts.firstIndex(of: element) {
                                ticketEditId = index
                            }
                            refreshID = UUID()
                            isEditSheetPresented = true
                        } label: {
                            Label("Edit", systemImage: "pencil").bold()
                        }.tint(.yellow.opacity(0.7)).frame(width:90)
                    }
                }.onDelete(perform: deleteTicket) //Delete Button
                    .frame(height: 200)
            }
            Spacer()
        }.sheet(isPresented: $isAddSheetPresented) {
            NewTicket()
        }
        .sheet(isPresented: $isEditSheetPresented) {
            EditTicket(ticketts: ticketts[ticketEditId])
        }
        .sheet(isPresented: $showEventEditViewController) {
            EventEditViewController(event: $event, eventStore: store)
        }
        .fullScreenCover(isPresented: $showTicketDetail) {
            TicketDetail(ticketts: ticketts[ticketDetailId])
        }
        .fullScreenCover(isPresented: $isMapPresented) {
            MapView(ticketts: ticketts[0], isMenu: true)
        }
        .id(refreshID)
    }
    //Delete Method
    func deleteTicket(offsets: IndexSet){
        withAnimation {
            offsets.map{
                ticketts[$0]
            }.forEach(moc.delete(_:))
            
            DataController().save(context: moc)
        }
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        Dashboard()
    }
}
