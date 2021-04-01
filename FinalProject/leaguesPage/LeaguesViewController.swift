//
//  ViewController.swift
//  FinalProject
//
//  Created by Mariam Ayman on 3/23/21.
//

import UIKit
import Alamofire
import SVProgressHUD
import SDWebImage


struct setID {
    static var details: setID = setID()

    var id: String = ""
}

class LeaguesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
  
    
    @IBOutlet weak var tableView: UITableView!
    internal var sportName: String?
    var arrleagues = [League]()
    var arrOfId :[String] = []
   
    var arrleaguesOfId:[LeagOfID]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       arrleaguesOfId = []
        SVProgressHUD.showSuccess(withStatus: "Loading...")
       getApi()
    }
    
   
    
    func getApi(){
        Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/all_leagues.php").responseJSON { (response) in
        
            do{
                let sportsResponse = try JSONDecoder().decode(LeagueBase.self, from: response.data!)
                self.arrleagues = sportsResponse.leagues
                    for i in 0..<self.arrleagues.count
                    {
                        if self.arrleagues[i].strSport.rawValue == self.sportName {
                            let id = self.arrleagues[i].idLeague
                            self.arrOfId.append(id)
                        }
                    }
                self.getLeguesById()
            }catch{
                print("error")
            }
        }
    }
    
    
    func getLeguesById(){
    
        for i in 0..<arrOfId.count
        {
    
        Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/lookupleague.php?id=\(arrOfId[i])").responseJSON { (response) in
        
            do{
                let sportsResponse = try JSONDecoder().decode(leguesOfId.self, from: response.data!)
                self.arrleaguesOfId!.append(contentsOf: sportsResponse.leagues)
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                    self.tableView.reloadData()
                }
            }catch{
                print("error")
            }
        }

    }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Leagues"
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrleaguesOfId!.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventView = self.storyboard!.instantiateViewController(withIdentifier: "LeaguesDetailesViewController") as! LeaguesDetailesViewController
        eventView.LeagueName = arrleaguesOfId![indexPath.row].title
        eventView.Leagueid = arrleaguesOfId![indexPath.row].id
        eventView.LeagueImage = arrleaguesOfId![indexPath.row].badge
        eventView.LeagueYoutube = arrleaguesOfId![indexPath.row].leagueYoutube
        setID.details.id = arrOfId[indexPath.row]
        self.present(eventView, animated: true) {
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesCustemTableViewCell
        
        cell.nameLeague.text=arrleaguesOfId![indexPath.row].title
        
        if(arrleaguesOfId![indexPath.row].badge != nil){
            cell.imageLegue?.sd_setImage(with: URL(string: arrleaguesOfId![indexPath.row].badge!), placeholderImage: UIImage(named: "sport"))
        }else{
            cell.imageLegue?.image = UIImage(named: "sport")
        }
       cell.btnYoutubeAction={
        
        if (self.arrleaguesOfId![indexPath.row].leagueYoutube != nil)
        {
        let linkVC = self.storyboard?.instantiateViewController(identifier: "WepKitController")
            as! WepKitController
            let stringUrl = self.arrleaguesOfId![indexPath.row].leagueYoutube
        linkVC.urlValue = "https://" + stringUrl!
        self.present(linkVC, animated: true, completion: nil)
        }
        else
        {
            cell.youtubeLink.isHidden=true
        }
        
       }
        return cell
    }
}

