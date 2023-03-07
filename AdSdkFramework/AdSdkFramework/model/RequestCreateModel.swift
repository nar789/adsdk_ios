

import Foundation


public struct RequestCreateModel : Codable {
    public var token:String
    
    public var type:String
    
    public var userInfo:UserInfo
}
