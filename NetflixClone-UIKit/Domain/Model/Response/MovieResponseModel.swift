//
//  MovieResponseModel.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 26/05/24.
//

import Foundation

// MARK: - MovieResponseModel
struct MovieResponseModel: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage, originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


extension MovieResponseModel {
    func toMovie() -> Movie {
        return Movie(
            adult: adult ?? false,
            backdropPath: backdropPath ?? "",
            genreIDS: genreIDS ?? [],
            id: id ?? 0,
            originalLanguage: originalLanguage ?? "",
            originalTitle: originalTitle ?? "",
            overview: overview ?? "",
            popularity: popularity ?? 0.0,
            posterPath: posterPath ?? "",
            releaseDate: releaseDate ?? "",
            title: title ?? "",
            video: video ?? false,
            voteAverage: voteAverage ?? 0.0,
            voteCount: voteCount ?? 0
        )
    }
}
