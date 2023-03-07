

import Foundation
import SwiftUI


public class AdSdkImpl : AdSdk {
    
    var baseUrl:String = ""
    var token:String = ""
    var httpClient:HttpClient? = nil
    
    public init() {
        
    }
    
    
    public func initApp(baseUrl:String, key: String) {
        print("initApp(), key = \(key)")
        self.baseUrl = baseUrl
        self.httpClient = HttpClient(baseUrl: baseUrl)
        httpClient?.postInit(key:key, completion: { result in
            switch result {
                case .success(let token):
                    self.token = token
                    print("token is \(self.token)")
                case .failure(let error):
                    print("error")
                    print(error.localizedDescription)
            }
        })
    }

    
    public func create(type:String, userInfo:UserInfo, callback:@escaping (_ item:ResponseCreateModel) -> Void) {
        if token.isEmpty {
            return
        }
        
        httpClient?.postCreate(token: token, type: type, userInfo: userInfo, completion: { result in
            switch result {
            case .success(let list):
                let idx = Int.random(in: 0...(list.count-1))
                print("random idx = \(idx)")
                callback(list[idx])
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        
    }
    
    public func on(adId:String, datetime:Int64, userInfo:UserInfo) {
        if token.isEmpty {
            return
        }
        
        httpClient?.postOn(token: token, adId: adId, datetime: datetime, userInfo: userInfo, completion: { result in
            switch result {
            case .success(let status):
                print("post on ret status = \(status)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        
    }
    

}
