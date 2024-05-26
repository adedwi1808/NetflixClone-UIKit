//
//  TvProgram.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 26/05/24.
//

import Foundation

struct TvProgram: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let name, originalLanguage, originalName, overview: String
    let posterPath, mediaType: String
    let genreIDS: [Int]
    let popularity: Double
    let firstAirDate: String
    let voteAverage: Double
    let voteCount: Int
    let originCountry: [String]
}
