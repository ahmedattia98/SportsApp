//
//  FavoriteCustemTableViewCell.swift
//  FinalProject
//
//  Created by Ahmed attia on 3/30/21.
//

import UIKit

class FavoriteCustemTableViewCell: UITableViewCell {
    @IBOutlet weak var imageLeague: UIImageView!
    
    @IBOutlet weak var nameLeague: UILabel!
    
    
    
    var btnYoutubeAction:(()-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageLeague.layer.cornerRadius=imageLeague.frame.size.width/2
        imageLeague.clipsToBounds=true
        imageLeague.layer.borderWidth=2
        imageLeague.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

    @IBAction func youtubeBtn(_ sender: Any) {
   
        btnYoutubeAction?()
        
    }
}
