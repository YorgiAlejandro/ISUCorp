//
//  OverView.swift
//  ISUCorp
//
//  Created by BeMillionaire on 1/23/24.
//

import SwiftUI

struct OverView: View {
    @State var isMapPresented: Bool = false
    @Environment(\.managedObjectContext) var moc //moc = managedObjectContext
    var ticketts: FetchedResults<Ticketts>.Element
    var body: some View {
        VStack {
            VStack {
                HStack{
                    VStack(alignment: .leading){
                        Text("Customer Info:")
                            .foregroundColor(.black.opacity(0.5))
                            .font(.title2)
                        HStack{
                            Text(ticketts.name ?? "")
                                .foregroundColor(.black.opacity(0.7))
                                .font(.title)
                                .fontWeight(.semibold)
                            Label {
                                Text("519 737 8787").foregroundColor(.gray)
                            } icon: {
                                Image(systemName: "phone.circle").foregroundColor(.green)
                            }
                            .font(.title2)

                        }
                    }
                    Spacer().frame(width:150)
                    VStack(alignment: .leading){
                        Text("Scheduled For:")
                            .foregroundColor(.black.opacity(0.5))
                            .font(.title2)
                        HStack {
                            Text("\(ticketts.schedule ?? Date(), style: .date)")
                            Text("\(ticketts.schedule ?? Date(), style: .time)")
                        }
                        .fontWeight(.semibold)
                        .font(.title)
                        .foregroundColor(.black.opacity(0.7))
                    }
                }
                Divider().padding(20)
                HStack{
                    HStack{
                        VStack(alignment: .leading){
                            VStack(alignment: .leading){
                                Label {
                                    Text("Job Site Address:").fontWeight(.semibold)
                                } icon: {
                                    Image(systemName: "mappin.and.ellipse")
                                }.foregroundColor(.black.opacity(0.5))
                                    .font(.title2).frame(width:210)
                                Text(ticketts.address ?? "").foregroundColor(.black.opacity(0.7))
                                    .font(.title)
                                    .frame(width:300, alignment: .leading)
                            }.padding(.bottom, 60)
                            VStack(alignment: .leading){
                                Label {
                                    Text("Distance:").fontWeight(.semibold)
                                } icon: {
                                    Image(systemName: "location")
                                }.foregroundColor(.black.opacity(0.5))
                                    .font(.title2)
                                Text("Aprox. 17 Minutes")
                                    .foregroundColor(.black.opacity(0.7))
                                        .font(.title)
                                Text("11.9 miles")
                                    .foregroundColor(.black.opacity(0.7))
                                        .font(.footnote)
                            }
                            
                        }.padding(.leading, 50)
                        Button("Get Directions"){
                            isMapPresented = true
                        }.padding(15).background(Color.green.opacity(0.8)).frame(width:170).foregroundColor(.white).bold().font(.title3).cornerRadius(15)
                    }
                    Divider().padding(.horizontal, 40)
                    VStack(alignment: .leading){
                        Label {
                            Text("Dispatch Note:")
                        } icon: {
                            Image(systemName: "note.text")
                        }.font(.title).foregroundColor(.gray)
                        Text("89$ Diagnostic Fee").font(.title2).foregroundColor(.gray)
                        Text("Air Handler Horizontal in the Attic, Condenser in backyard").font(.title2).foregroundColor(.gray)
                        Text("Units turns on and blows warm air").font(.title2).foregroundColor(.gray).padding(.bottom, 20)
                        Text("Problem Started 2 days ago and have never had an issue with unit. A/C units in approx. 15 years old").font(.title2).foregroundColor(.gray)
                        Divider()
                        HStack{
                            HStack{
                                Text("Dept. Class:").foregroundColor(.gray).font(.title2)
                                Text("Plumbing").foregroundColor(.black.opacity(0.8)).font(.system(size: 24))
                            }
                            HStack{
                                Text("Service Type:").foregroundColor(.gray).font(.title2)
                                Text("Call Back").foregroundColor(.black.opacity(0.8)).font(.system(size: 24))
                            }
                        }
                    }.padding(.trailing, 40)
                    Spacer()
                }
            }
            Rectangle().frame(height: 20).foregroundColor(.gray.opacity(0.1))
            HStack{
                Text("Reason for call:").fontWeight(.semibold).foregroundColor(.gray).font(.title2).padding(.leading, 15)
                Spacer()
                VStack(alignment: .leading){
                    Text("- Customer has noticed extremerly low water pressure from the sink.")
                        .foregroundColor(.gray).font(.title2)
                    Text("- Precesion Tune up")
                        .foregroundColor(.gray).font(.title2)
                    Text("- Estimate for panel upgrade")
                        .foregroundColor(.gray).font(.title2)
                }
                Spacer()
                Text("Ticket #\(ticketts.number ?? "")").fontWeight(.semibold).foregroundColor(.gray).font(.title2).padding(.trailing, 15)
            }.padding(.top, 40)
            Rectangle().frame(height: 6).foregroundColor(.gray.opacity(0.1))
        }.fullScreenCover(isPresented: $isMapPresented) {
            MapView(ticketts: ticketts, isMenu: false)
        }
    }
}

//struct OverView_Previews: PreviewProvider {
//    static var previews: some View {
//        OverView()
//    }
//}
