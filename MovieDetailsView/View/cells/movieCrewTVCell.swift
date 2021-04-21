//
//  movieCrewTVCell.swift
//  MovieMobileTask
//
//  Created by ALY on 09/04/2021.
//

import UIKit

class movieCrewTVCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var jobLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCrew(with model: Cast) {
        self.nameLbl.text = model.originalName
        self.jobLbl.text = model.job
    }
    
}
