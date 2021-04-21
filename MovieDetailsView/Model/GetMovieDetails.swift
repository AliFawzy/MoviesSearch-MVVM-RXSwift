//
//  GetMovieDetails.swift
//  MovieMobileTask
//
//  Created by ALY on 08/04/2021.
//

import Foundation



// MARK: - GetMovieDetails
class GetMovieDetails: Codable {
    let adult: Bool
    let backdropPath: String
    let belongsToCollection: BelongsToCollection
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID: String
    let originalLanguage: OriginalLanguage
    let originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let videos: Videos

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case videos
    }

    init(adult: Bool, backdropPath: String, belongsToCollection: BelongsToCollection, budget: Int, genres: [Genre], homepage: String, id: Int, imdbID: String, originalLanguage: OriginalLanguage, originalTitle: String, overview: String, popularity: Double, posterPath: String, productionCompanies: [ProductionCompany], productionCountries: [ProductionCountry], releaseDate: String, revenue: Int, runtime: Int, spokenLanguages: [SpokenLanguage], status: String, tagline: String, title: String, video: Bool, voteAverage: Double, voteCount: Int, videos: Videos) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.belongsToCollection = belongsToCollection
        self.budget = budget
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.imdbID = imdbID
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.productionCompanies = productionCompanies
        self.productionCountries = productionCountries
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.runtime = runtime
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.videos = videos
    }
}

// MARK: - BelongsToCollection
class BelongsToCollection: Codable {
    let id: Int
    let name, posterPath, backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }

    init(id: Int, name: String, posterPath: String, backdropPath: String) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }
}

// MARK: - Genre
class Genre: Codable {
    let id: Int
    let name: String

    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

enum OriginalLanguage: String, Codable {
    case en = "en"
}

// MARK: - ProductionCompany
class ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: OriginCountry

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }

    init(id: Int, logoPath: String?, name: String, originCountry: OriginCountry) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
    }
}

enum OriginCountry: String, Codable {
    case us = "US"
}

// MARK: - ProductionCountry
class ProductionCountry: Codable {
    let iso3166_1: OriginCountry
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }

    init(iso3166_1: OriginCountry, name: String) {
        self.iso3166_1 = iso3166_1
        self.name = name
    }
}

// MARK: - SpokenLanguage
class SpokenLanguage: Codable {
    let englishName: String
    let iso639_1: OriginalLanguage
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }

    init(englishName: String, iso639_1: OriginalLanguage, name: String) {
        self.englishName = englishName
        self.iso639_1 = iso639_1
        self.name = name
    }
}

// MARK: - Videos
class Videos: Codable {
    let results: [videoResult]

    init(results: [videoResult]) {
        self.results = results
    }
}

// MARK: - Result
class videoResult: Codable {
    let id: String
    let iso639_1: OriginalLanguage
    let iso3166_1: OriginCountry
    let key, name: String
    let site: Site
    let size: Int
    let type: String

    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case key, name, site, size, type
    }

    init(id: String, iso639_1: OriginalLanguage, iso3166_1: OriginCountry, key: String, name: String, site: Site, size: Int, type: String) {
        self.id = id
        self.iso639_1 = iso639_1
        self.iso3166_1 = iso3166_1
        self.key = key
        self.name = name
        self.site = site
        self.size = size
        self.type = type
    }
}

enum Site: String, Codable {
    case youTube = "YouTube"
}
