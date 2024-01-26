//
//  ContentView.swift
//  ISUCorp
//
//  Created by BeMillionaire on 1/22/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var isLoggedIn = IsLoggedIn()
    
    var body: some View {
        VStack{
            if isLoggedIn.isLoggedIn {
                Dashboard()
            } else {
                Login()
            }
        }.environmentObject(isLoggedIn)
    }
}
class IsLoggedIn: ObservableObject{
    @Published var isLoggedIn: Bool = false
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
