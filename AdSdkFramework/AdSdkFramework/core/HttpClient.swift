
import Foundation


enum NetworkError: Error {
    case badURL
    case noData
    case decodingError
}

class HttpClient {
    
    var baseUrl:String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func postOn(token:String, adId:String, datetime:Int64, userInfo:UserInfo, completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        let req = RequestOnModel(token: token, adId: adId, datetime: datetime, userInfo: userInfo)
        let json = try? JSONEncoder().encode(req)
        
        guard let url = URL.getOnURL(base: baseUrl) else {
            return completion(.failure(.badURL))
        }
        
        var requestUrl = URLRequest(url:url)
        requestUrl.httpMethod = "POST"
        requestUrl.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestUrl.httpBody = json
        
        
        print("postOn(), request url \(requestUrl)")
        
        
        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let result = String(data:data, encoding: .utf8) ?? ""
            
            completion(.success(result))
            
        }.resume()
        
    }
    
    func postCreate(token:String, type:String, userInfo:UserInfo,
                    completion: @escaping (Result<[ResponseCreateModel], NetworkError>) -> Void) {
        
        let req = RequestCreateModel(token: token, type: type, userInfo: userInfo)
        let json = try? JSONEncoder().encode(req)
        
        guard let url = URL.getCreateURL(base: baseUrl) else {
            return completion(.failure(.badURL))
        }
        
        var requestUrl = URLRequest(url:url)
        requestUrl.httpMethod = "POST"
        requestUrl.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestUrl.httpBody = json
        
        
        print("postCreate(), request url \(requestUrl)")
        
        
        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            
            guard let results = try? JSONDecoder().decode([ResponseCreateModel].self, from: data) else {
                return completion(.failure(.decodingError))
            }
            
            completion(.success(results))
            
        }.resume()
        
    }
    
    
    func postInit(key:String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        
        let params:[String:String] = ["key" : key]
        let body = try! JSONSerialization.data(withJSONObject: params)
        
        guard let url = URL.getInitURL(base: baseUrl) else {
            return completion(.failure(.badURL))
        }
        
        var requestUrl = URLRequest(url:url)
        requestUrl.httpMethod = "POST"
        requestUrl.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestUrl.httpBody = body
        
        
        print("postInit(), request url \(requestUrl)")
        
        
        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            
            let token:String = String(data: data, encoding: .utf8) ?? ""
            
            completion(.success(token))
            
        }.resume()
        
    }
}
