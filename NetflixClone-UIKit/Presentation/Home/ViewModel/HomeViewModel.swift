//
//  HomeViewModel.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 20/05/24.
//

import Foundation

protocol HomeViewModelDelegateProtocol: AnyObject {
    func onSuccessGetNowPlaying()
    func onSuccessGetPopular()
    func onSuccessGetTopRated()
    func onSuccessGetTrendingMovies()
    func onSuccessGetUpcoming()
    func onSuccessGetTrendingTv()
}

protocol HomeViewModelProtocol: AnyObject {
    var services: any HomeServicesProtocol { get }
    var nowPlayingMovies: [Movie] { get set }
    var popularMovies: [Movie] { get set }
    var topRatedMovies: [Movie] { get set }
    var trendingMovies: [Movie] { get set }
    var upcomingMovies: [Movie] { get set }
    var trendingTv: [TvProgram] { get set }
    
    var delegate: HomeViewModelDelegateProtocol? { get set }
    
    func viewDidLoad()
    func getNowPlaying()
    func getPopular()
    func getTopRated()
    func getTrendingMovies()
    func getUpcoming()
    func getTrendingTv()
}

class HomeViewModel: HomeViewModelProtocol {
    var trendingTv: [TvProgram] = []
    var popularMovies: [Movie] = []
    var topRatedMovies: [Movie] = []
    var trendingMovies: [Movie] = []
    var upcomingMovies: [Movie] = []
    var nowPlayingMovies: [Movie] = []
    
    let services: any HomeServicesProtocol
    
    weak var delegate: HomeViewModelDelegateProtocol?
    
    init(services: any HomeServicesProtocol) {
        self.services = services
    }
    
    func viewDidLoad() {
        getNowPlaying()
        getPopular()
        getTopRated()
        getTrendingMovies()
        getUpcoming()
        getTrendingTv()
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
    
    func getPopular() {
        services.getPopular { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    popularMovies = response.results?.compactMap({$0.toMovie()}) ?? []
                    delegate?.onSuccessGetPopular()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTopRated() {
        services.getTopRated { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    topRatedMovies = response.results?.compactMap({$0.toMovie()}) ?? []
                    delegate?.onSuccessGetTopRated()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTrendingMovies() {
        services.getTrendingMovies { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    trendingMovies = response.results?.compactMap({$0.toMovie()}) ?? []
                    delegate?.onSuccessGetTrendingMovies()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getUpcoming() {
        services.getUpcoming { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    upcomingMovies = response.results?.compactMap({$0.toMovie()}) ?? []
                    delegate?.onSuccessGetUpcoming()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTrendingTv() {
        services.getTrendingTv { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    trendingTv = response.results?.compactMap({$0.toTvProgram()}) ?? []
                    delegate?.onSuccessGetTrendingTv()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
