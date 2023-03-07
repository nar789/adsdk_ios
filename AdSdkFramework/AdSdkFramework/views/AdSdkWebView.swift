

import SwiftUI
import WebKit

public struct AdSdkWebView: UIViewRepresentable {
    var urlToLoad: String
    @State var webview:WKWebView = WKWebView()
    
    public init(urlToLoad: String, webview: WKWebView) {
        self.urlToLoad = urlToLoad
        self.webview = webview
    }
       
    public func makeUIView(context: Context) -> WKWebView {
    
        guard let url = URL(string: urlToLoad) else{
            return WKWebView()
        }
     
        webview.allowsBackForwardNavigationGestures = true
        webview.load(URLRequest(url: url))
        return webview
   }
    
   public func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<AdSdkWebView>) {
   }
    
}

