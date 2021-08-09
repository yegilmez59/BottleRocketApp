//
//  NetworkManager.swift
//  BottleRocketApp
//
//  Created by Yagmur Egilmez on 8/8/21.
//

import Foundation

protocol NetworkService {
    func fetchDecodableData<T: Decodable>(url: URL?, completion: @escaping (Result<T, Error>) -> Void)
    func fetchRawData(url: URL?, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkManager {
    var session: Session
    
    init(session: Session = URLSession.shared) {
        self.session = session
    }
}

extension NetworkManager: NetworkService {
    func fetchDecodableData<T: Decodable>(url: URL?, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(NetworkError.badURL))
            return
        }
        
        self.session.getData(with: url) { [weak self] (data,response,error) in
            guard let self = self else { return }
            var jsonData = Data()
            do {
                jsonData = try self.performErrorChecking(data, response, error).get()
            } catch {
                completion(.failure(error))
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: jsonData)
                completion(.success(result))
            } catch {
                print(error)
                completion(.failure(NetworkError.decodeFailure))
            }
            
        }
    }
    
    func fetchRawData(url: URL?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = url else {
            completion(.failure(NetworkError.badURL))
            return
        }
        self.session.getData(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            
            do {
                let data = try self.performErrorChecking(data, response, error).get()
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func performErrorChecking(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Result<Data, Error> {
        if let error = error {
            return .failure(error)
        }

        if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
            return .failure(NetworkError.badStatusCode(httpResponse.statusCode))
        }

        guard let data = data else {
            return .failure(NetworkError.badData)
        }

        return .success(data)
    }
    
}
