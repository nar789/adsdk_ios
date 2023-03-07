

import Foundation


public protocol AdSdk {
    
    func initApp(baseUrl:String, key: String)
    
    func create(type:String, userInfo:UserInfo, callback:@escaping (_ item:ResponseCreateModel) -> Void)
    
    func on(adId:String, datetime:Int64, userInfo:UserInfo)
    
    
}
