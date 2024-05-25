//
//  NetworkService.swift
//  GeeksProTest
//
//  Created by Apple on 25.5.2024.
//

import Foundation


struct NetworkService {
    
    enum HttpMethods: String {
        case GET, POST, PUT, DELETE
    }
    
    private let decoder = JSONDecoder()

    
    func getPersons(complition: @escaping (Result<[PersonDTO], Error>) -> Void) {
        let request = URLRequest(url: Constants.baseURL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                complition(.failure(error))
                return
            }
            
            guard let data = data else {
                complition(.failure(error!))
                return
            }
            
            do {
                let model = try decoder.decode(PersonsDTO.self, from: data)
                complition(.success(model.results))
            } catch {
                complition(.failure(error))
                print("\(error.localizedDescription)")
            }
        }.resume()
    }
}
