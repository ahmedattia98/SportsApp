//
//  TeamTableViewCell.swift
//  FinalProject
//
//  Created by Mariam Ayman on 3/28/21.
//

import UIKit
import Alamofire
import SVProgressHUD
import SDWebImage
class TeamsTableViewCell: UITableViewCell{
    
    @IBOutlet weak var teamCollectionView: UICollectionView!
    

    var arrayTeams = [TeamsInfo]()
    var idTeam :String!
    
    
    
    func configure(team:Bool){
        teamCollectionView.delegate=self
        teamCollectionView.dataSource=self
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        idTeam=setID.details.id
        print(idTeam!)
        
        SVProgressHUD.showInfo(withStatus: "Loading...")
        getApiTeams { (response) in
            SVProgressHUD.dismiss()
            self.teamCollectionView.reloadData()
        }
        
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    func getApiTeams(completion:@escaping (Any?)->Void){
        Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/lookup_all_teams.php?id=\(idTeam!)").responseJSON { (response) in
            do{

                let teamsResponse = try JSONDecoder().decode(TeamsModel.self, from: response.data!)
                self.arrayTeams = teamsResponse.teams!
                    completion(teamsResponse)
            }catch{
                print("error")
            }
        }
    }

}
extension TeamsTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayTeams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"teamcollectioncell", for: indexPath) as! TeamCollectionViewCell
        if(arrayTeams[indexPath.row].strTeamBadge != nil){
            cell.teamLogo?.sd_setImage(with: URL(string: arrayTeams[indexPath.row].strTeamBadge!), placeholderImage: UIImage(named: "sport"))
        }else{
            cell.teamLogo?.image = UIImage(named: "sport")
        }
        
        cell.teamLogo.layer.cornerRadius = cell.teamLogo.frame.height/2
        cell.teamLogo.layer.masksToBounds=false
        cell.teamLogo.layer.borderWidth=2
        cell.teamLogo.layer.backgroundColor=#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.teamLogo.clipsToBounds = true
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentview :UIViewController = self.window!.rootViewController!
        let teamDetailsView = currentview.storyboard!.instantiateViewController(identifier: "TeamDetailsTable") as! TeamDetailsTable
        teamDetailsView.arrDetails = self.arrayTeams[indexPath.row
        ]
        currentview.presentedViewController!.present(teamDetailsView, animated: true, completion: nil)
        
    }
}
