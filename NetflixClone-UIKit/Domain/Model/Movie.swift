//
//  Movie.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 26/05/24.
//

import Foundation

struct Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}
