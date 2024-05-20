//
//  HomeServices.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 20/05/24.
//

import Foundation

protocol HomeServicesProtocol: AnyObject {
    var networker: NetworkerProtocol { get }
    
    
}

final class HomeServices: HomeServicesProtocol {
    var networker: any NetworkerProtocol
    
    init(networker: any NetworkerProtocol = Networker()) {
        self.networker = networker
    }
    
}
