
import Foundation


public struct ResponseCreateModel : Codable, Identifiable {
    
    public var id: String {
        adId
    }
    public var adId:String
    public var imgUrl:String
    public var href:String
    public var traceUrl:String
    
    
}
