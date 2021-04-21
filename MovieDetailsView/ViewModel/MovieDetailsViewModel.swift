//
//  MovieDetailsViewModel.swift
//  MoviesSearch-MVVM-RXSwift
//
//  Created by ALY on 20/04/2021.
//

import Foundation
import RxSwift
import RxCocoa


class MovieDetailsViewModel {
    var loadingBehavoir = BehaviorRelay<Bool>(value: false)
    var rechabilityBehavoir = BehaviorRelay<Bool>(value: false)
    
    private var arrMovieDetails = PublishSubject<GetMovieDetails>()
    var arrMoviesDetailsObserver: Observable<GetMovieDetails> {
        return arrMovieDetails
    }
    private var arrMovieCrew = PublishSubject<[Cast]>()
    var arrMovieCrewObserver: Observable<[Cast]> {
        return arrMovieCrew
    }
    private var arrMovieCast = PublishSubject<[Cast]>()
    var arrMovieCastObserver: Observable<[Cast]> {
        return arrMovieCast
    }
    var videoKey = BehaviorRelay<String>(value: "")
    var movieId = BehaviorRelay<Int>(value: 0)
    
    
    func getMovieDetailsApi(completed:@escaping ()->())  {
        self.loadingBehavoir.accept(true)
        self.rechabilityBehavoir.accept(true)
            var dictParam:[String:Any] = [String:Any]()
            dictParam["api_key"] = USER_API_KEY
            dictParam["append_to_response"] = "videos"
            
        guard let  url = URL(string: Constant_URL.SERVICE_URL + METHOD_NAME.movie + "/\(movieId.value)?" + dictParam.queryString) else {
                print("error in url")
                self.loadingBehavoir.accept(false)
                return
            }
            print("credits url \(url)")
            var request = URLRequest(url: url)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil{
                    do{
                        
                        let arrMovieDetails = try JSONDecoder().decode(GetMovieDetails.self, from: data!)

                        DispatchQueue.main.async {
                            self.arrMovieDetails.onNext(arrMovieDetails)
                           


                            self.loadingBehavoir.accept(false)
                            
                        }
                    }catch {
                        self.loadingBehavoir.accept(false)
                        ProgressHUD.showError(error.localizedDescription)

                    }
                }
            }.resume()
            
        
    }
    
    func getMovieVideossApi(completed:@escaping ()->())  {
        self.loadingBehavoir.accept(true)
            var dictParam:[String:Any] = [String:Any]()


            dictParam["api_key"] = USER_API_KEY

        guard let  url = URL(string: Constant_URL.SERVICE_URL + METHOD_NAME.movie + "/\(movieId.value)/videos?" + dictParam.queryString) else {
                self.loadingBehavoir.accept(false)
                return
                
            }
            print("videos url \(url)")
            var request = URLRequest(url: url)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil{
                    do{

                        let arrvideos = try JSONDecoder().decode(GetMovieVideos.self, from: data!)

                        DispatchQueue.main.async {
                            self.loadingBehavoir.accept(false)
                            self.videoKey.accept(arrvideos.results[0].key)
                            
                        }
                    }catch {
                        self.loadingBehavoir.accept(false)
                        ProgressHUD.showError(error.localizedDescription)

                    }
                }
            }.resume()


    }
    
    
    
    func getMovieCreditsApi(completed:@escaping ()->())  {
        self.loadingBehavoir.accept(true)
            var dictParam:[String:Any] = [String:Any]()
            dictParam["api_key"] = USER_API_KEY
            dictParam["language"] = "en-US"

        guard let  url = URL(string: Constant_URL.SERVICE_URL + METHOD_NAME.movie + "/\(movieId.value)/" + "credits?" + dictParam.queryString) else {
            self.loadingBehavoir.accept(false)
            return
            
        }
            print("credits url \(url)")
            var request = URLRequest(url: url)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil{
                    do{

                        let credits = try JSONDecoder().decode(GetMovieCredits.self, from: data!)

                        DispatchQueue.main.async {
                            
                            self.arrMovieCrew.onNext(credits.crew)
                            self.arrMovieCast.onNext(credits.cast)
                            self.loadingBehavoir.accept(false)

                        }
                    }catch {
                        self.loadingBehavoir.accept(false)
                        ProgressHUD.showError(error.localizedDescription)

                    }
                }
            }.resume()





    }
}
