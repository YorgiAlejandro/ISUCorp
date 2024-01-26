//
//  TicketDetail.swift
//  ISUCorp
//
//  Created by BeMillionaire on 1/23/24.
//

import SwiftUI

struct TicketDetail: View {
    var ticketts: FetchedResults<Ticketts>.Element
    @Environment(\.managedObjectContext) var moc //moc = managedObjectContext
    @Environment(\.dismiss) var dismiss
    @State var isMapPresented: Bool = false
    
    var body: some View {
        VStack {
            //NavBar
            HStack{
                Button {
                    dismiss()
                } label: {
                    VStack{
                        Image(systemName:"chevron.left").bold()
                        Text("Dashboard")
                    }.padding(.leading, 20)
                }
                .foregroundColor(.green.opacity(0.7))
                .padding(10)
                .font(.title3)
                Spacer()
                Text("Work Ticket")
                    .font(.title)
                    .foregroundColor(.gray.opacity(0.7))
                    .bold()
                Spacer()
                
                Button {
                    isMapPresented = true
                } label: {
                    VStack{
                        Image(systemName: "line.horizontal.3")
                            .bold()
                        Text("Menu")
                    }.padding(.trailing, 20)
                }
                .foregroundColor(.green.opacity(0.7))
                .padding(10)
                .font(.title2)
            }
            .padding(10)
            .background(Color.gray.opacity(0.1))
            //Content
            TabView{
                OverView(ticketts: ticketts)
                    .tabItem {
                        Label("Overview", systemImage: "info.circle")
                    }
                WorkDetails()
                    .tabItem {
                        Label("Work Details", systemImage: "newspaper.circle")
                    }
                Purchasing()
                    .tabItem {
                        Label("Purchasing", systemImage: "cart.circle")
                    }
                Finish()
                    .tabItem {
                        Label("Finishing Up", systemImage: "checkmark.circle")
                    }
                Camera()
                    .tabItem {
                        Label("Camera", systemImage: "camera.fill")
                    }
            }.accentColor(.green)
            Spacer()

            
        }.fullScreenCover(isPresented: $isMapPresented) {
            MapView(ticketts: ticketts, isMenu: true)
        }
    }
}

//struct TicketDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        TicketDetail()
//    }
//}
