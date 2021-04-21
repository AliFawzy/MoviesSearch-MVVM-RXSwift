//
//  MovieDetailsViewController.swift
//  MovieMobileTask
//
//  Created by ALY on 08/04/2021.
//

import UIKit
import YoutubePlayer_in_WKWebView
import RxSwift
import RxCocoa
import SDWebImage


class MovieDetailsViewController: baiseViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var backBtnOutlet: UIButton!
    @IBOutlet weak var rateLbl: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var crewTableView: UITableView!
    
    @IBOutlet weak var MovieGeneresLbl: UILabel!
    @IBOutlet weak var timeDateLbl: UILabel!
    @IBOutlet weak var movieTitleLbl: UILabel!
   
    @IBOutlet weak var overViewDetails: UILabel!
    @IBOutlet weak var castCV: UICollectionView!
    
    @IBOutlet weak var playerView: WKYTPlayerView!
    @IBOutlet weak var notAvailableimage: UIImageView!{
        didSet{
            notAvailableimage.isHidden = true
        }
    }
    
    
    
    
    // MARK: - Variables
    var movieId = 0
    let crewTVCell  = "movieCrewTVCell"
    let castCVCell  = "movieCastCVCell"
    let movieDetailsViewModel = MovieDetailsViewModel()
    let tapGesture = UITapGestureRecognizer()
    let disposeBage = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup_Table_Collection_View()
        subscribeLoading()
        bindingMovieId()
        subscribeMovieDetailsResponse()
        subscribeMovieVideo()
        subscribeBackBtn()
        subscribeShowPosterBtn()
        subscribeCastResponse()
        
        
        
    }
    // MARK: - Functions
    
    func setup_Table_Collection_View() {
        crewTableView.register(UINib(nibName: self.crewTVCell, bundle: nil), forCellReuseIdentifier: self.crewTVCell)
        castCV.register(UINib(nibName: self.castCVCell , bundle: nil), forCellWithReuseIdentifier:  self.castCVCell)
        castCV.rx.setDelegate(self).disposed(by: disposeBage)
    }
    
    func subscribeLoading(){
        movieDetailsViewModel.loadingBehavoir.subscribe(onNext: {  (isLoading) in
          
            if isLoading{
                ProgressHUD.show()
            }else{
                ProgressHUD.dismiss()
            }
        }).disposed(by: disposeBage)
    }
    
    func bindingMovieId() {
        let id = BehaviorRelay<Int>(value: movieId)
        id.bind(to: movieDetailsViewModel.movieId).disposed(by: disposeBage)
        if isConnectedToNetwork(){
            self.movieDetailsViewModel.getMovieDetailsApi(){}
        }else{
            ProgressHUD.showError("please check Your internet")
        }
        
    }
    
    func subscribeMovieDetailsResponse(){
        movieDetailsViewModel.arrMoviesDetailsObserver.subscribe(onNext: {
            let posterUrl = Constant_URL.movie_Poster_Url + "\($0.posterPath)"
            self.posterImage.sd_setImage(with: URL(string: posterUrl), placeholderImage: #imageLiteral(resourceName: "no image"))
            
            let BackGroundImgUrl = Constant_URL.movie_Poster_Url + "\($0.backdropPath )"
            self.backGroundImage.sd_setImage(with: URL(string: BackGroundImgUrl), placeholderImage: #imageLiteral(resourceName: "no image"))
            
            self.rateLbl.text = "\($0.voteAverage)"
            self.timeDateLbl.text = "\($0.runtime ) min | \($0.releaseDate )"
            for index in  $0.genres.enumerated(){
                if  index.offset == 0{
                    self.MovieGeneresLbl.text = "\(index.element.name) | "
                }else if index.offset == $0.genres.count - 1{
                    self.MovieGeneresLbl.text = self.MovieGeneresLbl.text! + "\(index.element.name)"
                }else{
                    self.MovieGeneresLbl.text = self.MovieGeneresLbl.text! + "\(index.element.name) | "
                }
            }
            self.movieTitleLbl.text = $0.originalTitle
            self.overViewDetails.text = $0.overview
                }).disposed(by: disposeBage)
    }
    
    func subscribeMovieVideo(){
        if self.isConnectedToNetwork(){
            self.movieDetailsViewModel.getMovieVideossApi(){}
            self.movieDetailsViewModel.videoKey.subscribe(onNext: {
                self.playerView.load(withVideoId: $0)
            }).disposed(by: disposeBage)
        }else{
            ProgressHUD.showError("please check Your internet")
        }
    }

    func subscribeBackBtn(){
        backBtnOutlet.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let self = self else {return}
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBage)
    }
    
    func subscribeShowPosterBtn(){
        posterImage.addGestureRecognizer(tapGesture)
        self.tapGesture.rx.event.bind(onNext: {  recognizer in
            let imageView = recognizer.view as! UIImageView
            let newImageView = UIImageView(image: imageView.image)
            newImageView.frame = UIScreen.main.bounds
            newImageView.backgroundColor = .black
            newImageView.contentMode = .scaleAspectFit
            newImageView.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullscreenImage))
            newImageView.addGestureRecognizer(tap)
            self.view.addSubview(newImageView)
            self.navigationController?.isNavigationBarHidden = true
        }).disposed(by: disposeBage)
    }
    
   @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
   
    func subscribeCastResponse(){
        if self.isConnectedToNetwork(){
            self.movieDetailsViewModel.getMovieCreditsApi(){}
            movieDetailsViewModel.arrMovieCrewObserver.bind(to: self.crewTableView.rx.items(cellIdentifier: self.crewTVCell, cellType: movieCrewTVCell.self)){ (row, result, cell) in
                cell.selectionStyle = .none
                cell.configureCrew(with: result)
            }.disposed(by: disposeBage)
            
            movieDetailsViewModel.arrMovieCastObserver.bind(to: self.castCV.rx.items(cellIdentifier: self.castCVCell, cellType: movieCastCVCell.self)){ (row, result, cell) in
                cell.configureCast(with: result)
            }.disposed(by: disposeBage)
        }else{
            ProgressHUD.showError("please check Your internet")
        }
    }
}

extension MovieDetailsViewController:  UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let cell = CGSize(width:collectionView.frame.height   , height: collectionView.frame.height )
            return cell
        }
}
