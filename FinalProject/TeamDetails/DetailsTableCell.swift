//
//  DetailsTableCell.swift
//  FinalProject
//
//  Created by Ahmed Attia on 3/29/21.
//

import UIKit

class DetailsTableCell: UITableViewCell {

    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var teamLogo: UIImageView!
    
    @IBOutlet weak var imageTshirt: UIImageView!
    
    @IBOutlet weak var imageStadium: UIImageView!
    
    @IBOutlet weak var nameCountry: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var nameStadium: UILabel!
    
    
    @IBOutlet weak var officialPage: UIButton!
    
    @IBOutlet weak var faceBookPage: UIButton!
    
    @IBOutlet weak var youTubeLink: UIButton!
    
    var btnYoutube:(()-> Void)?
    var btnFacebook:(()-> Void)?
    var btnOfficial:(()-> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func officialLink(_ sender: Any) {
        btnOfficial?()
    }
    
    @IBAction func youtubeLinking(_ sender: Any) {
        btnYoutube?()
    }
    @IBAction func facebookLinking(_ sender: Any) {
        btnFacebook?()
    }
    
    
    
}
