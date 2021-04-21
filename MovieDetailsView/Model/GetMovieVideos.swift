//
//  GetMovieVideos.swift
//  MovieMobileTask
//
//  Created by ALY on 09/04/2021.
//

import Foundation



// MARK: - GetMovieVideos
class GetMovieVideos: Codable {
    let id: Int
    let results: [getVideo]

    init(id: Int, results: [getVideo]) {
        self.id = id
        self.results = results
    }
}

// MARK: - Result
class getVideo: Codable {
    let id: String
    let iso639_1: ISO639_1
    let iso3166_1: ISO3166_1
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

    init(id: String, iso639_1: ISO639_1, iso3166_1: ISO3166_1, key: String, name: String, site: Site, size: Int, type: String) {
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

enum ISO3166_1: String, Codable {
    case us = "US"
}

enum ISO639_1: String, Codable {
    case en = "en"
}


