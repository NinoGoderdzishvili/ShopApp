//
//  NetworkService.swift
//  ShopApp
//
//  Created by Nino Goderdzishvili on 1/23/23.
//

import Foundation

class NetworkService {
    static var shared = NetworkService()
    private var session = URLSession()
    
    init() {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        self.session = urlSession
    }
    
    func getData<T: Codable>(urlString: String,
                             expecting: T.Type,
                             complition: @escaping (Result<T, Error>) -> Void) {
        
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                print("wrong response")
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let object = try decoder.decode(expecting, from: data)
                complition(.success(object))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}
