//
//  FavoriteViewController.swift
//  FinalProject
//
//  Created by Ahmed attia on 3/30/21.
//

import UIKit
import CoreData
class FavoriteViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var favorites:[FavoriteLeague]?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.reloadData()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchCoreData()
        self.tableView.reloadData()
    }
    
    
    func fetchCoreData(){
        do{
            self.favorites = try context.fetch(FavoriteLeague.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch
        {
            print("not fetch data from core data")
        }
    }

}
extension FavoriteViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteCustemTableViewCell
        
        cell.nameLeague.text=favorites![indexPath.row].name
        
        if(favorites![indexPath.row].badgeURL != nil){
            cell.imageLeague?.sd_setImage(with: URL(string: favorites![indexPath.row].badgeURL!), placeholderImage: UIImage(named: "sport"))
        }else{
            cell.imageLeague?.image = UIImage(named: "sport")
        }
       cell.btnYoutubeAction={
        if (self.favorites![indexPath.row].youtubeURL != nil)
        {
        let linkVC = self.storyboard?.instantiateViewController(identifier: "WepKitController")
            as! WebKitView
        let stringUrl = self.favorites![indexPath.row].youtubeURL
        linkVC.urlValue = "https://" + stringUrl!
        self.present(linkVC, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Alert", message: "Not Found", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            
        }
    }
        
    
    return cell
   }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let eventView = self.storyboard!.instantiateViewController(withIdentifier: "LeaguesDetailesViewController") as! LeaguesDetailesViewController
        if favorites![indexPath.row].id != nil
        {
        setID.details.id = favorites![indexPath.row].id!
            
            self.present(eventView, animated: true) {
                eventView.favBtn.isHidden=true
               
                eventView.leagueNameLable.text = self.favorites![indexPath.row].name
            }
        
        }
        else
        {
            let alert = UIAlertController(title: "Alert", message: "Not Found", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let favoriteRemove = self.favorites![indexPath.row]
        
        self.context.delete(favoriteRemove)
        do{
            try self.context.save()
        }catch{
            print("not remove")
        }
        fetchCoreData()
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Favorite Leagues ♥️ "
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}
