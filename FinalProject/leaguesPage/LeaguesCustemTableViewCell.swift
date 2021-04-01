//
//  LeaguesCustemTableViewCell.swift
//  FinalProject
//
//  Created by Mariam Ayman on 3/23/21.
//

import UIKit

class LeaguesCustemTableViewCell: UITableViewCell {

    @IBOutlet weak var youtubeLegue: UIButton!
    @IBOutlet weak var nameLeague: UILabel!
    @IBOutlet weak var imageLegue: UIImageView!
    
    @IBOutlet weak var youtubeLink: UIButton!
    var btnYoutubeAction:(()-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageLegue.layer.cornerRadius=imageLegue.frame.size.width/2
        imageLegue.clipsToBounds=true
        imageLegue.layer.borderWidth=2
        imageLegue.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func openYoutube(_ sender: Any) {
        
        btnYoutubeAction?()
        
    }
}
