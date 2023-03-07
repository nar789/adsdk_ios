

import Foundation


public struct UserInfo : Codable {
    public var sex : String
    public var age : String
    
    public init(sex: String, age: String) {
        self.sex = sex
        self.age = age
    }
}
