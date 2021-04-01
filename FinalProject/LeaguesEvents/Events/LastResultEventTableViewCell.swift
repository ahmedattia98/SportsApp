//
//  LastResultTableViewCell.swift
//  FinalProject
//
//  Created by Mariam Ayman on 3/28/21.
//

import UIKit
import Alamofire
import SVProgressHUD


class LastResultEventTableViewCell: UITableViewCell{
   
    @IBOutlet weak var LastResultCollectionView: UICollectionView!
    var idEvent :String!
    var arrayEvents = [EventsInfo]()
    func configure(lastResult:Bool){
        LastResultCollectionView.delegate=self
        LastResultCollectionView.dataSource=self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        idEvent=setID.details.id
        print(idEvent!)
        
        startLoading()
        getApiLatestEvents { (eventsResponse) in
            self.finishLoading()
            self.LastResultCollectionView.reloadData()
            
        }
    }
    
    
    func startLoading(){
        SVProgressHUD.show(withStatus: "Loading...")
    }
    func finishLoading(){
        SVProgressHUD.dismiss()
    }
    
        func getApiLatestEvents(completion:@escaping (Any?)->Void){
            Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=\(idEvent!)").responseJSON { (response) in
                do{

                    let eventsResponse = try JSONDecoder().decode(EventsModel.self, from: response.data!)
                    self.arrayEvents = eventsResponse.events!
                        completion(eventsResponse)
                }catch{
                    print("error")
                }
            }
        }
        
        
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
}

extension LastResultEventTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "lastresultcollection", for: indexPath) as! LastResultEventCollectionViewCell
        cell.teamOne.text=arrayEvents[indexPath.row].strHomeTeam
        cell.teamTwo.text=arrayEvents[indexPath.row].strAwayTeam
        cell.dateOfEvent.text=arrayEvents[indexPath.row].strTimeLocal
        cell.firstNum.text=arrayEvents[indexPath.row].intHomeScore
        cell.secondNum.text=arrayEvents[indexPath.row].intAwayScore
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
        IndexPath) -> CGSize {
        
        
        return CGSize(width: LastResultCollectionView.frame.size.width, height:LastResultCollectionView.frame.size.height)
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
        return 0.5
    }
        
    
}

