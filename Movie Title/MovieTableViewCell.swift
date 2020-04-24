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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    static let identifier = "MovieTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "MovieTableViewCell",
                     bundle: nil)
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
