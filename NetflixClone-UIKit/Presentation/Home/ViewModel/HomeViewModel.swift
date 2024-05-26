//
//  HomeViewModel.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 20/05/24.
//

import Foundation

protocol HomeViewModelDelegateProtocol: AnyObject {
    func onSuccessGetNowPlaying()
}

protocol HomeViewModelProtocol: AnyObject {
    var services: any HomeServicesProtocol { get }
    var nowPlayingMovies: [Movie] { get set }
    var delegate: HomeViewModelDelegateProtocol? { get set }
    
    func viewDidLoad()
    func getNowPlaying()
}

class HomeViewModel: HomeViewModelProtocol {
    var nowPlayingMovies: [Movie] = []
    
    let services: any HomeServicesProtocol
    
    weak var delegate: HomeViewModelDelegateProtocol?
    
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
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    nowPlayingMovies = response.results?.compactMap({$0.toMovie()}) ?? []
                    delegate?.onSuccessGetNowPlaying()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
