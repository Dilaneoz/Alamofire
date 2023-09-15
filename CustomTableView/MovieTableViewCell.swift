//
//  MovieTableViewCell.swift
//  CustomTableView
//
//  Created by Opendart Yazılım ve Bilişim Hizmetleri on 12.02.2023.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieTeamName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
