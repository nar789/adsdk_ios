
import Foundation


extension URL {
    
    
    static func getInitURL(base:String) -> URL? {
         return URL(string: "\(base)/init")
    }
    
    static func getCreateURL(base:String) -> URL? {
        return URL(string: "\(base)/create")
    }
    
    static func getOnURL(base:String) -> URL? {
        return URL(string: "\(base)/on")
    }
}
