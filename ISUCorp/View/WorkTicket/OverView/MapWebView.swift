//Is a webView for show GoogleMaps as a web inside the app
import SwiftUI
import WebKit

struct MapWebView: UIViewRepresentable {
    
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest (url : URL(string: url)!))
    }
}
