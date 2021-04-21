//
//  SearchViewController.swift
//  MoviesSearch-MVVM-RXSwift
//
//  Created by ALY on 20/04/2021.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: baiseViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var viewOfSearch: UIView!{
        didSet{
            viewOfSearch.layer.cornerRadius = viewOfSearch.frame.height / 2
        }
    }
    
    @IBOutlet weak var searchTxtView: UITextField!{
        didSet{
            searchTxtView.attributedPlaceholder = NSAttributedString(string: "Search Movie", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        }
    }
    @IBOutlet weak var moviesTableView: UITableView!
    
    let searchViewModel = SearchViewModel()
    let searchTVCell = "searchMovieTVCell"
    let disposeBage = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchMovies()
        subscribeLoading()
        subscribeResponse()
        subscribeSearchBtn()
        setupTableView()
        subscibeTableCellSelection()
    }
    
    func searchMovies() {
        
        searchTxtView.rx.controlEvent([.editingChanged])
                .asObservable().subscribe({ [unowned self] _ in
                searchTxtView.rx.text.orEmpty.bind(to: searchViewModel.searchBehavoir).disposed(by: disposeBage)
                    if self.isConnectedToNetwork(){
                        self.searchViewModel.getMovieData()
                    }else{
                        ProgressHUD.showError("please check Your internet")
                    }
                }).disposed(by: disposeBage)
        
        
    }
    func subscribeResponse(){
        searchViewModel.arrMoviesObserver.bind(to: self.moviesTableView.rx.items(cellIdentifier: self.searchTVCell, cellType: searchMovieTVCell.self)){ (row, result, cell) in
            cell.selectionStyle = .none
            cell.configure(with: result)
            
        }.disposed(by: disposeBage)
    }
    func subscribeLoading(){
        searchViewModel.loadingBehavoir.subscribe(onNext: {  (isLoading) in
          
            if isLoading{
                ProgressHUD.show()
            }else{
                ProgressHUD.dismiss()
            }
        }).disposed(by: disposeBage)
    }
    func subscribeSearchBtn(){
        searchBtn.rx.tap.throttle(RxTimeInterval.seconds(Int(0.5)), scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] (_) in
            guard let self = self else {return}
            if self.isConnectedToNetwork(){
                self.searchViewModel.getMovieData()
            }else{
                ProgressHUD.showError("please check Your internet")
            }
        }).disposed(by: disposeBage)
    }
    func setupTableView()  {
        moviesTableView.register(UINib(nibName: self.searchTVCell, bundle: nil), forCellReuseIdentifier: searchTVCell)
        moviesTableView.rx.setDelegate(self).disposed(by: disposeBage)
    }
    func subscibeTableCellSelection(){
        Observable.zip(moviesTableView.rx.itemSelected, moviesTableView.rx.modelSelected(Result.self)).bind {  selectedIndex, branch in
            print("selected branch \(branch.title)")
            let vc = MovieDetailsViewController.init()
            vc.movieId = branch.id
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(vc, animated: true)
            
        }.disposed(by: disposeBage)
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCREEN_HEIGHT * 0.25
    }
}

