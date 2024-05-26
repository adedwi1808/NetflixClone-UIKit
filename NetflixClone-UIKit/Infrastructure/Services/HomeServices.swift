//
//  HomeServices.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 20/05/24.
//

import Foundation

protocol HomeServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    
    func getNowPlaying(completion: @escaping (Result<PaginationResponseModel<MovieResponseModel>, NetworkError>) -> Void)
}

final class HomeServices: HomeServicesProtocol {
    var networker: any NetworkerProtocol
    
    init(networker: any NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
    func getNowPlaying(completion: @escaping (Result<PaginationResponseModel<MovieResponseModel>, NetworkError>) -> Void) {
        networker.networkTask(type: PaginationResponseModel<MovieResponseModel>.self, endPoint: .nowPlaying, isMultipart: false, completion: completion)
    }
}
