

import SwiftUI
import WebKit
import AdSdkFramework
import SDWebImageSwiftUI

struct ContentView: View {
    @State var isShowAd:Bool = false
    @State var isShowWebView:Bool = false
    @State var webview = WKWebView()
    @State var url:String = ""
    @State var href:String = ""
    
    let sdk:AdSdk = AdSdkImpl()
    
    
    
    func getBaseUrl() -> String {
        return "http://14.47.39.138:3311"
    }
    
    func getKey() -> String {
        return "test1234"
    }
    
    func getUserInfo() -> UserInfo {
        return UserInfo(sex: "female", age: "22")
    }
    
    func onAppear() {
        sdk.initApp(baseUrl: getBaseUrl(), key: getKey())
        
    }
    
    func postCreate(type:String) {
        sdk.create(type: type, userInfo: getUserInfo()) { res in
            url = res.imgUrl
            href = res.href
            self.isShowAd.toggle()
            let datetime = Date().millisecondsSince1970
            sdk.on(adId: res.adId, datetime: datetime, userInfo: getUserInfo())
        }
    }
    
   
    
    var body: some View {
        let width = UIScreen.main.bounds.size.width * 0.9
        let height = UIScreen.main.bounds.size.height * 0.9
        
        ZStack  {
            VStack {
                VStack {
                    Image(systemName: "globe")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                    Text("Click -> Create AD")
                }
                .onTapGesture {
                  postCreate(type: "POPUP")
                }
            }
            
            if isShowAd {
                VStack {
                    
                    WebImage(url : URL(string:url))
                        .onTapGesture {
                            print("ad img clicked")
                            isShowAd.toggle()
                            isShowWebView.toggle()
                        }
                    
                }.frame(maxWidth: width, maxHeight: height)
                    .cornerRadius(20)
            }
            
            if isShowWebView {
                VStack {
                    HStack {
                        Spacer().frame(width:10)
                        Button("뒤로가기") {
                            if(webview.canGoBack) {
                                webview.goBack()
                            }
                        }
                        Spacer()
                        Button("닫기") {
                            isShowWebView.toggle()
                        }
                        Spacer().frame(width:10)
                        
                    }
                    AdSdkWebView(urlToLoad: href, webview: webview)
                }
            }
         
        }
        .onAppear {
            onAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
