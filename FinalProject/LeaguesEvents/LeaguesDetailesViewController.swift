//
//  LeaguesDetailesViewController.swift
//  FinalProject
//
//  Created by Mariam Ayman on 3/28/21.
//

import UIKit
import SVProgressHUD
import Alamofire
import CoreData
class LeaguesDetailesViewController: UIViewController{
    @IBOutlet weak var leagueNameLable: UILabel!
    internal var LeagueName: String?
    internal var Leagueid: String?
    internal var LeagueYoutube: String?
    internal var LeagueImage: String?
    
    @IBOutlet weak var favBtn: UIButton!
    
//<<<<<<< Updated upstream
    var isFavorite = false
//=======
 //    var isFavorite = false
//>>>>>>> Stashed changes
    var favLeague = [NSManagedObject]()
    var myIndex=0
   
    var appDelegate: AppDelegate?
    var context :NSManagedObjectContext?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
        fetchFav()
        leagueNameLable.text=LeagueName
    }
   // override func viewWillAppear(_ animated: Bool) {}
    
    @IBAction func favoriteAction(_ sender: Any) {
        if isFavorite == false
       {
            addFav()
       }
        else if isFavorite == true
       {
        DeleteFavouriteLeague()
       }

    }
    func fetchFav(){
      //  let fetchRequest = NSFetchRequest<FavoriteLeague>.self(entityName: "FavoriteLeague")
        do {
            favLeague = try context!.fetch(FavoriteLeague.fetchRequest())        } catch let error as NSError {
            print(error)
        }
        var count = 0
        for i in favLeague{
            if i.value(forKeyPath: "id") as? String == self.Leagueid{
                self.favBtn.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
                self.myIndex=count
                isFavorite = true
            }
            count += 1
        }
    }
    func addFav(){
        
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteLeague", in: context!)
        let myFavorite = NSManagedObject(entity: entity!, insertInto: context)
        myFavorite.setValue(Leagueid, forKey: "id")
        myFavorite.setValue(LeagueName, forKey: "name")
        myFavorite.setValue(LeagueYoutube, forKey: "youtubeURL")
        myFavorite.setValue(LeagueImage, forKey: "badgeURL")
        do{
            try context?.save()
            self.fetchFav()
            isFavorite = true
                self.favBtn.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            print("data saved")
        }catch let error as NSError{
            print(error)
        }
    }
    func DeleteFavouriteLeague(){
        context?.delete(favLeague[self.myIndex] as! FavoriteLeague)
        do{
            try context?.save()
            print("deleted here")
            isFavorite = false
            self.favBtn.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }catch let error as NSError{
            print("Not Deleted")
            print(error)
        }
    }
}
extension LeaguesDetailesViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
   if (indexPath.section==0)
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath) as! UpComingEventTableCell
        cell.configure(upcomming: true)
            return cell
            
    }
   else if (indexPath.section==1)
        {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lastresult", for: indexPath) as! LastResultTableViewCell
    
        cell.configure(lastResult: true)
            
            return cell
   }else{
    let cell = tableView.dequeueReusableCell(withIdentifier: "teamcell", for: indexPath) as! TeamsTableViewCell
    cell.configure(team: true)
        
        return cell
    
   }
}
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.section==0)
        {
            return 195
        }else if (indexPath.section==1)
        {
            return 290
        }else
        {
            return 190
        }
    }
  
   
}
