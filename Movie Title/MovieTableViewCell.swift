//
//  MovieTableViewCell.swift
//  Movie Title
//
//  Created by Alaa Adel on 4/22/20.
//  Copyright © 2020 Alaa Adel. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    
    @IBOutlet weak var moviesBackgroundView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cellDesign()
    }

    static let identifier = "MovieTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MovieTableViewCell",
                     bundle: nil)
    }
    func cellDesign() {
        self.moviesBackgroundView.layer.cornerRadius = 25
        self.moviesBackgroundView.layer.borderWidth = 3
        self.moviesBackgroundView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.moviesBackgroundView.clipsToBounds = true
    }
    func configure(with model: Movie) {
        self.movieTitleLabel.text = model.Title
        self.movieYearLabel.text = model.Year
        let url = model.Poster
        if let data = try? Data(contentsOf: URL(string: url)!) {
            self.movieImageView.image = UIImage(data: data)
        }
    }
    
}
