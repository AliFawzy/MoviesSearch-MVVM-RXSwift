//
//  GetMovieCredits.swift
//  MovieMobileTask
//
//  Created by ALY on 08/04/2021.
//

import Foundation



// MARK: - GetMovieCredits
class GetMovieCredits: Codable {
    let id: Int
    let cast, crew: [Cast]

    init(id: Int, cast: [Cast], crew: [Cast]) {
        self.id = id
        self.cast = cast
        self.crew = crew
    }
}

// MARK: - Cast
class Cast: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment, name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    let department, job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }

    init(adult: Bool, gender: Int, id: Int, knownForDepartment: String, name: String, originalName: String, popularity: Double, profilePath: String?, castID: Int?, character: String?, creditID: String, order: Int?, department: String?, job: String?) {
        self.adult = adult
        self.gender = gender
        self.id = id
        self.knownForDepartment = knownForDepartment
        self.name = name
        self.originalName = originalName
        self.popularity = popularity
        self.profilePath = profilePath
        self.castID = castID
        self.character = character
        self.creditID = creditID
        self.order = order
        self.department = department
        self.job = job
    }
}
