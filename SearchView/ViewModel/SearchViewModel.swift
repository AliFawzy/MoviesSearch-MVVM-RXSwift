//
//  SearchViewModel.swift
//  MoviesSearch-MVVM-RXSwift
//
//  Created by ALY on 20/04/2021.
//

import Foundation
import RxSwift
import RxCocoa
import  Alamofire

class SearchViewModel {
    var searchBehavoir = BehaviorRelay<String>(value: "")
    var loadingBehavoir = BehaviorRelay<Bool>(value: false)
    private var arrMoviesSubject = PublishSubject<[Result]>()
    var arrMoviesObserver: Observable<[Result]> {
        return arrMoviesSubject
    }
    
   
    
    func getMovieData()  {
        self.loadingBehavoir.accept(true)
            var dictParam:[String:Any] = [String:Any]()
          
            dictParam["api_key"] = USER_API_KEY
            dictParam["language"] = "en-US"
            dictParam["page"] = 1
            dictParam["include_adult"] = false
            dictParam["query"] = self.searchBehavoir.value
           print("paramters \(dictParam)")
            guard let  url = URL(string: Constant_URL.SERVICE_URL + METHOD_NAME.SearchMovies + "?" + dictParam.queryString) else { return  }
            print("movies url \(url)")
            var request = URLRequest(url: url)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error == nil{
                    do{
                        let arrMovies = try JSONDecoder().decode(GetSearhedMovies.self, from: data!)

                        DispatchQueue.main.async {
                            self.loadingBehavoir.accept(false)
                            self.arrMoviesSubject.onNext(arrMovies.results)
                        }
                        
                    }catch {
                        self.loadingBehavoir.accept(false)
                        ProgressHUD.showError(error.localizedDescription)
                    }
                }
            }.resume()
    }
   
}
