//
//  movieCastCVCell.swift
//  MovieMobileTask
//
//  Created by ALY on 09/04/2021.
//

import UIKit

class movieCastCVCell: UICollectionViewCell {
    @IBOutlet weak var viewOfImag: UIView!    
    @IBOutlet weak var castImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCast(with model: Cast) {
        let posterUrl = Constant_URL.movie_Poster_Url + "\(model.profilePath ?? "")"
        castImage.sd_setImage(with: URL(string: posterUrl), placeholderImage: #imageLiteral(resourceName: "no image"))
        
    }

}
