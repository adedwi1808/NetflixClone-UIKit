//
//  Networker.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 19/05/24.
//

import Foundation


protocol NetworkerProtocol: AnyObject {
    func networkTask<T>(
        type: T.Type,
        endPoint: NetworkFactory,
        isMultipart: Bool,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) where T: Decodable
}

final  class Networker: NetworkerProtocol {
    let session = URLSession.shared
    
    func networkTask<T>(
        type: T.Type,
        endPoint: NetworkFactory,
        isMultipart: Bool,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) where T : Decodable {
        self.networker(endPoint: endPoint,
                       isMultipart: isMultipart,
                       completion: { result in
            switch result {
            case .success((let data, let response)):
                do {
                    let decodedData = try self.responseHandler(type: T.self, data: data, response: response)
                    completion(.success(decodedData))
                } catch let error as NetworkError {
                    completion(.failure(error))
                } catch {
                    completion(.failure(.decodingError(message: error.localizedDescription)))
                }
                break
            case .failure(let error):
                if let errorNetworkError = error as? NetworkError {
                    completion(.failure(errorNetworkError))
                } else {
                    completion(.failure(NetworkError.internetError(message: "Connection Error")))
                }
                break
            }
        })
    }
}

//MARK: - Networker Strategy
extension Networker {
    private func networker(
        endPoint: NetworkFactory,
        isMultipart: Bool,
        completion: @escaping (Result<(Data, URLResponse), any Error>) -> Void
    ) {
        if isMultipart {
            do {
                let task = try session.uploadTask(
                    with:  endPoint.urlRequestMultiPart,
                    from: endPoint.createBodyWithParameters(
                        parameters: endPoint.bodyParam ?? [:],
                        imageDataKey: endPoint.data
                    )
                ) { data, response, error in
                    if let error = error {
                        completion(.failure(error))
                    } else if let data = data, let response = response {
                        completion(.success((data, response)))
                    } else {
                        completion(.failure(NetworkError.middlewareError(code: 500, message: "No data or response")))
                    }
                }
                
                task.resume()
            } catch  {
                completion(.failure(error))
            }
        } else {
            let task = session.dataTask(
                with: endPoint.urlRequest
            ) { data, response , error in
                if let error = error {
                    completion(.failure(error))
                } else if let data = data, let response = response {
                    completion(.success((data, response)))
                } else {
                    completion(.failure(NetworkError.middlewareError(code: 500, message: "No data or response")))
                }
            }
            
            task.resume()
        }
    }
}

//MARK: - Handle Response
extension Networker {
    private func responseHandler<T>(
        type: T.Type,
        data: Data,
        response: URLResponse
    ) throws -> T where T: Decodable{
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.middlewareError(code: 500, message: "Connection Error")
        }
        
#if DEBUG
        let dataString = String(decoding: data, as: UTF8.self)
        print("Response : \(dataString)")
#endif
        
        guard 200..<300 ~= httpResponse.statusCode else {
            if httpResponse.statusCode == 401 {
                throw NetworkError.unAuthorized
            }
            throw NetworkError.decodingError(message: "STATUS CODE > 300")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch let decodingError as DecodingError {
#if DEBUG
            print(decodingError)
#endif
            throw NetworkError.decodingError(message: decodingError.errorDescription ?? "")
        }
    }
}
