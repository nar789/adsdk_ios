
import Foundation

public struct RequestOnModel : Codable{
    
    public var token:String
    
    public var adId:String
    
    public var datetime:Int64
    
    public var userInfo:UserInfo
}
