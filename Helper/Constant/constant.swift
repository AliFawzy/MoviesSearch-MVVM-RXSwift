//
//  constant.swift
//  Parties
//
//  Created by ALY on 11/4/20.
//

import UIKit



class Constant_URL: NSObject {

    private static let url = "https://api.themoviedb.org"
    
    private static let BASE_URL = url
    public static let SERVICE_URL = "\(BASE_URL)/3/"
    
    public static let movie_Poster_Url = "https://image.tmdb.org/t/p/w500/"
    
   

}

struct METHOD_NAME {
    
    public static let totalMovies = "movie/popular"
    public static let SearchMovies = "search/movie"
    public static let movie = "movie"
    
}

public  let APP_NAME = "Movies App"
public  let USER_API_KEY = "aa322dea420e07994d45098cc38824cf"

public  let SCREEN_WIDTH = UIScreen.main.bounds.size.width
public  let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
public  let userDefault = UserDefaults.standard

