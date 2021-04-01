//
//  TeamDetailsTable.swift
//  FinalProject
//
//  Created by Ahmed Attia on 3/29/21.
//

import UIKit
import SVProgressHUD
import SDWebImage
import Alamofire



class TeamDetailsTable: UITableViewController {
    
    var arrDetails = TeamsInfo()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        self.tableView.reloadData()
        
    }

   

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return 1
    }
    
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 670
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsTableCell", for: indexPath) as! DetailsTableCell
        
        cell.teamName.text = arrDetails.strTeam
        cell.nameCountry.text = arrDetails.strCountry
        cell.dateLabel.text = arrDetails.intFormedYear
        cell.nameStadium.text = arrDetails.strStadium
        
        if(arrDetails.strTeamBadge != nil){
            cell.teamLogo?.sd_setImage(with: URL(string: arrDetails.strTeamBadge!), placeholderImage: UIImage(named: "sport"))
        }else{
            cell.teamLogo?.image = UIImage(named: "sport")
        }
        
        if(arrDetails.strTeamJersey != nil){
            cell.imageTshirt?.sd_setImage(with: URL(string: arrDetails.strTeamJersey!), placeholderImage: UIImage(named: "sport"))
        }else{
            cell.imageTshirt?.image = UIImage(named: "sport")
        }
        if(arrDetails.strStadiumThumb != nil){
            cell.imageStadium?.sd_setImage(with: URL(string: arrDetails.strStadiumThumb!), placeholderImage: UIImage(named: "sport"))
        }else{
            cell.imageStadium?.image = UIImage(named: "sport")
        }
        cell.btnOfficial={
            if (self.arrDetails.strWebsite != nil)
            {
            let linkVC = self.storyboard?.instantiateViewController(identifier: "WepKitController")
                as! WebKitView
            let stringUrl = self.arrDetails.strWebsite
            linkVC.urlValue = "https://" + stringUrl!
            self.present(linkVC, animated: true, completion: nil)
            }
            else{
                cell.officialPage.isHidden=true
            }
        }
        cell.btnFacebook={
            if (self.arrDetails.strFacebook != nil)
            {
            let linkVC = self.storyboard?.instantiateViewController(identifier: "WepKitController")
                as! WebKitView
            let stringUrl = self.arrDetails.strFacebook
            linkVC.urlValue = "https://" + stringUrl!
            self.present(linkVC, animated: true, completion: nil)
            }
            else
            {
                cell.faceBookPage.isHidden = true
            }
        }
        cell.btnYoutube={
            if (self.arrDetails.strYoutube != nil)
            {
            let linkVC = self.storyboard?.instantiateViewController(identifier: "WepKitController")
                as! WebKitView
            let stringUrl = self.arrDetails.strYoutube
            linkVC.urlValue = "https://" + stringUrl!
            self.present(linkVC, animated: true, completion: nil)
            }
            else
            {
                cell.youTubeLink.isHidden=true
            }
        }
        
        return cell
    }
    

}
