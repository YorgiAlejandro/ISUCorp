//
//  WorkDetails.swift
//  ISUCorp
//
//  Created by BeMillionaire on 1/23/24.
//

import SwiftUI
import WebKit

struct WorkDetails: View {
    @State private var showWebView = false
    private let url = "https://www.google.com/maps/place/Cienfuegos,+Cuba/"
    var body: some View {
        Text("WorkDetails")
    }
}



struct WorkDetails_Previews: PreviewProvider {
    static var previews: some View {
        WorkDetails()
    }
}
