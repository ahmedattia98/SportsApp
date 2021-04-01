//
//  SportsViewController.swift
//  FinalProject
//
//  Created by Mariam Ayman on 3/23/21.
//

import UIKit
import SVProgressHUD
import SDWebImage
import Alamofire
import Reachability
class SportsViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var arrSports = [SportInfo]()
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
                self.startLoading()
                self.getApi { (sportsResponse) in
                    self.finishLoading()
                    self.collectionView.reloadData()
                }
                
            }else{
                print("Reachable via Cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            let alert = UIAlertController(title: "Alert", message: "NO Internet....!", preferredStyle: UIAlertController.Style.alert)
               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
               self.present(alert, animated: true, completion: nil)
            print("Not reachable")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        

       
    
    }

    func startLoading(){
        SVProgressHUD.show(withStatus: "Loading....")
    }
    func finishLoading(){
        SVProgressHUD.dismiss()
    }
    
    func getApi(completion:@escaping (Any?)->Void){
        Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/all_sports.php").responseJSON { (response) in
            do{

                let sportsResponse = try JSONDecoder().decode(Sport.self, from: response.data!)
                self.arrSports = sportsResponse.sports!
                    completion(sportsResponse)
            }catch{
                print("error")
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrSports.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"SportsCell", for: indexPath) as! SportsCollectionViewCell
        cell.layer.cornerRadius = 25
        cell.layer.masksToBounds = true
        cell.imageSport?.sd_setImage(with: URL(string: self.arrSports[indexPath.row].strSportThumb!))
        cell.nameSport.text=arrSports[indexPath.row].strSport
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         
         
     let size = CGSize(width:(collectionView.frame.size.width-10)/2, height: (collectionView.frame.size.width-10)/2)
         return size
         
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let leagesView = self.storyboard!.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
        leagesView.sportName = arrSports[indexPath.row].strSport
        self.navigationController?.pushViewController(leagesView, animated: true)
    }
}

