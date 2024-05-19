//
//  NetworkError.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 19/05/24.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case middlewareError(code: Int, message: String)
    case internetError(message: String)
    case decodingError(message: String)
    case unAuthorized
    
    var localizedDescription: String {
        switch self {
        case .middlewareError(_, let message):
            return message
        case .internetError:
            return ""
        case .decodingError(let message):
            return message
        case .unAuthorized:
            return "unauthorized"
        }
    }
    
    var isUnAuthorized: Bool {
        switch self {
        case .middlewareError:
            return false
        case .internetError:
            return false
        case .decodingError:
            return false
        case .unAuthorized:
            return true
        }
    }
}
