//
//  TvResponseModel.swift
//  NetflixClone-UIKit
//
//  Created by Ade Dwi Prayitno on 26/05/24.
//

import Foundation

// MARK: - TvResponseModel
struct TvResponseModel: Codable {
    let adult: Bool?
    let backdropPath: String?
    let id: Int?
    let name, originalLanguage, originalName, overview: String?
    let posterPath, mediaType: String?
    let genreIDS: [Int]?
    let popularity: Double?
    let firstAirDate: String?
    let voteAverage: Double?
    let voteCount: Int?
    let originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, name
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originCountry = "origin_country"
    }
}


extension TvResponseModel {
    func toTvProgram() -> TvProgram {
        return TvProgram(
            adult: self.adult ?? false,
            backdropPath: self.backdropPath ?? "",
            id: id ?? 0,
            name: self.name ?? "",
            originalLanguage: self.originalLanguage ?? "",
            originalName: self.originalName ?? "",
            overview: self.overview ?? "",
            posterPath: self.posterPath ?? "",
            mediaType: self.mediaType ?? "",
            genreIDS: genreIDS ?? [],
            popularity: popularity ?? 0.0,
            firstAirDate: self.firstAirDate ?? "",
            voteAverage: voteAverage ?? 0.0,
            voteCount: voteCount ?? 0,
            originCountry: self.originCountry ?? []
        )
    }
}
