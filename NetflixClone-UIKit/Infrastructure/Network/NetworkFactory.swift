//
//  NetworkFactory.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 19/05/24.
//

import Foundation

enum NetworkFactory {
    case sample
    case trendingMovies
}

extension NetworkFactory {
    
    // MARK: URL PATH API
    var path: String {
        switch self {
        case .sample:
            return ""
        case .trendingMovies:
            return "trending/movie/day"
        }
    }
    
    // MARK: URL QUERY PARAMS / URL PARAMS
    var queryItems: [URLQueryItem] {
        switch self {
        default:
            return [
                
            ]
        }
    }
    
    // MARK: BASE URL API
    var baseApi: String? {
        let tmbdBaseURL: String = ConfigurationManager.shared.getValue(forKey: .tmbdBaseURL)
        
        switch self {
        default:
            return tmbdBaseURL
        }
    }
    
    // MARK: URL LINK
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseApi
        let finalParams: [URLQueryItem] = self.queryItems
        components.queryItems = finalParams
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        return url
    }
    
    // MARK: HTTP METHOD
    var method: RequestMethod {
        switch self {
        case .sample, .trendingMovies:
            return .get
        }
    }
    
    enum RequestMethod: String {
        case delete = "DELETE"
        case get = "GET"
        case patch = "PATCH"
        case post = "POST"
        case put = "PUT"
    }
    
    // MARK: BODY PARAMS API
    var bodyParam: [String: Any]? {
        switch self {
        default:
            return [:]
        }
    }
    
    var boundary: String {
        let appToken = ConfigurationManager.shared.getValue(forKey: .tmbdApiKey)
        let boundary: String = "Boundary-\(appToken)"
        return boundary
    }
    
    // MARK: MULTIPART DATA
    var data: [(paramName: String, fileData: Data, fileName: String)]? {
        switch self {
        default:
            return nil
        }
    }
    
    // MARK: HEADER API
    var headers: [String: String]? {
        switch self {
        default :
            return getHeaders(type: .anonymous)
        }
    }
    
    
    enum HeaderType {
        case anonymous
        case authorized
        case appToken
        case multiPart
    }
    
    fileprivate func getHeaders(type: HeaderType) -> [String: String] {
        
        let accessToken = ConfigurationManager.shared.getValue(forKey: .tmbdAccessToken)
        let appToken = ConfigurationManager.shared.getValue(forKey: .tmbdApiKey)
        
        var header: [String: String]
        
        switch type {
        case .anonymous:
            header = [:]
        case .authorized:
            header = ["Content-Type": "application/json",
                      "Accept": "*/*",
                      "Authorization": "Basic \(accessToken)"]
        case .multiPart:
            header = ["Content-Type": "multipart/form-data; boundary=\(boundary)",
                      "Accept": "*/*",
                      "Authorization": "Basic \(accessToken)"]
        case .appToken:
            header = ["Content-Type": "application/json",
                      "Accept": "*/*",
                      "Authorization": "Basic \(appToken)"]
        }
        return header
    }
    
    func createBodyWithParameters(parameters: [String: Any], imageDataKey: [(paramName: String, fileData: Data, fileName: String)]?) throws -> Data {
        let body = NSMutableData()
        
        for (key, value) in parameters {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)".data(using: .utf8)!)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        if let imageData = imageDataKey {
            for datum in imageData {
                if datum.fileData.count > 0,
                   datum.fileData != Data() {
                    body.append("--\(boundary)\r\n".data(using: .utf8)!)
                    body.append("Content-Disposition: form-data; name=\"\(datum.paramName)\"; filename=\"\(datum.fileName)\"\r\n".data(using: .utf8)!)
                    body.append("Content-Type: \(datum.fileData.mimeType)\r\n\r\n".data(using: .utf8)!)
                    body.append(datum.fileData)
                    body.append("\r\n".data(using: .utf8)!)
                }
            }
        }
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body as Data
    }
    
    var urlRequestMultiPart: URLRequest {
        var urlRequest = URLRequest(url: self.url)
        urlRequest.httpMethod = method.rawValue
        if let header = headers {
            header.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let bodyParam = bodyParam, let datas = data {
            urlRequest.httpBody = try? createBodyWithParameters(parameters: bodyParam, imageDataKey: datas) as Data
        }
        
        return urlRequest
    }
    
    var urlRequest: URLRequest {
        var urlRequest = URLRequest(url: self.url, timeoutInterval: 10.0)
        var bodyData: Data?
        urlRequest.httpMethod = method.rawValue
        if let header = headers {
            header.forEach { (key, value) in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let bodyParam = bodyParam, method != .get {
            do {
                bodyData = try JSONSerialization.data(withJSONObject: bodyParam, options: [.prettyPrinted])
                urlRequest.httpBody = bodyData
            } catch {
                // swiftlint:disable disable_print
#if DEBUG
                print(error)
#endif
                // swiftlint:enable disable_print
            }
        }
        return urlRequest
    }
}
