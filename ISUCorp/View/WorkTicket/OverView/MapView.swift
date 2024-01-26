//
//  MapView.swift
//  ISUCorp
//
//  Created by BeMillionaire on 1/24/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var refreshID = UUID()
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc //moc = managedObjectContext
    var ticketts: FetchedResults<Ticketts>.Element
    var isMenu: Bool
    @State var mapAPI = MapApi()
    @State private var ubication = ""
    @State var once = true
    
    var body: some View {
        VStack{
            //NavBar
            HStack{
                Button {
                    dismiss()
                } label: {
                    VStack{
                        Image(systemName: "chevron.left")
                        Text("Ticket")
                    }.foregroundColor(.green.opacity(0.8)).font(.title2)
                }
                Spacer()
                Text("Get Directions").bold().font(.largeTitle).foregroundColor(.gray.opacity(0.9))
                Spacer()
            }.padding(15)
            .background(Color.gray.opacity(0.1))
            Spacer()
            //Address Finder
            HStack {
                TextField("Insert an address", text: $ubication)
                    .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
                Button("Search on the map"){
                    mapAPI.getLocation(address: ubication, delta: 0.5)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        refreshID = UUID()
                    }
                }.buttonStyle(.borderedProminent).tint(.green.opacity(0.8)).padding(.horizontal, 40)
            }
            //Map
            Map(coordinateRegion: $mapAPI.region, annotationItems: mapAPI.locations){location in
                MapMarker(coordinate: location.coordinate, tint: .blue)
            }
            .ignoresSafeArea()
            .onAppear{
                if once {
                    if !isMenu{
                        ubication = ticketts.address ?? ""
                        mapAPI.getLocation(address: ubication, delta: 0.5)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            refreshID = UUID()
                        }
                        once = false
                    }
                }else{
                    //Do nothing
                }
            }
        }
        .id(refreshID)
    }
}

