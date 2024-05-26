//
//  MovieSectionViewModel.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 26/05/24.
//

import Foundation

protocol MovieSectionViewModelProtocol: AnyObject {
    var movies: [Movie] { get set }
    var tvPrograms: [TvProgram] { get set }
    var type: MovieSectionType { get set }
}

class MovieSectionViewModel: MovieSectionViewModelProtocol {
    var movies: [Movie] = []
    var tvPrograms: [TvProgram] = []
    var type: MovieSectionType = .movie
    
    init(movies: [Movie]) {
        self.movies = movies
        self.type = .movie
    }
    
    init(tvPrograms: [TvProgram]) {
        self.tvPrograms = tvPrograms
        self.type = .tvProgram
    }
}
