//
//  searchMovieTVCell.swift
//  MovieMobileTask
//
//  Created by ALY on 08/04/2021.
//

import UIKit
import SDWebImage

class searchMovieTVCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var movieNameLbl: UILabel!
    @IBOutlet weak var movieRateLbl: UILabel!
    @IBOutlet weak var movieTimeDateLbl: UILabel!
    @IBOutlet weak var movieDescriptionLbl: UILabel!
    @IBOutlet weak var posterIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(with model: Result) {
        self.movieNameLbl.text = model.originalTitle
        self.movieRateLbl.text = "\(model.voteAverage)"
        self.movieTimeDateLbl.text = model.releaseDate
        self.movieDescriptionLbl.text = model.overview
        
        let url = Constant_URL.movie_Poster_Url + "\(model.posterPath ?? "")"
        posterIcon.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "no image"))
        
    }
}
