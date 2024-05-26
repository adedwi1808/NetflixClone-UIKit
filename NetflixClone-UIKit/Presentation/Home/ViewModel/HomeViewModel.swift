//
//  HomeViewModel.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 20/05/24.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var services: any HomeServicesProtocol { get }
    
    func viewDidLoad()
    func getNowPlaying()
}

class HomeViewModel: HomeViewModelProtocol {
    let services: any HomeServicesProtocol
    
    init(services: any HomeServicesProtocol) {
        self.services = services
    }
    
    func viewDidLoad() {
        getNowPlaying()
    }
    
    func getNowPlaying() {
        services.getNowPlaying { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
