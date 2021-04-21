//
//  search moviesErrorModel.swift
//  MoviesSearch-MVVM-RXSwift
//
//  Created by ALY on 20/04/2021.
//

import Foundation

class searchMoviesErrorModel: Codable {
    let statusCode: Int?
    let statusMessage, success: String?
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
    
    init(status_code: Int, status_message: String, success: String ) {
        statusCode  = status_code
        statusMessage  = status_message
        self.success = success
    }
    
}

