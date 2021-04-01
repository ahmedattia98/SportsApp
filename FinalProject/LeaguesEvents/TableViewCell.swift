//
//  TableViewCell.swift
//  FinalProject
//
//  Created by Mariam Ayman on 3/28/21.
//

import UIKit
import Alamofire
import SVProgressHUD
class UpCommingTableViewCell: UITableViewCell {

    @IBOutlet weak var upCommiingCollection: UICollectionView!
    
    var arrayEvents = [EventsInfo]()
    func configure(upcomming:Bool){
        upCommiingCollection.delegate=self
        upCommiingCollection.dataSource=self
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        getApiLatestEvents { (eventsResponse) in
            self.upCommiingCollection.reloadData()
            
        }
    
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    func startLoading(){
        SVProgressHUD.show(withStatus: "Loading...")
    }
    func finishLoading(){
        SVProgressHUD.dismiss()
    }
    
   
    func getApiLatestEvents(completion:@escaping (Any?)->Void){
        Alamofire.request("https://www.thesportsdb.com/api/v1/json/1/eventspastleague.php?id=4328").responseJSON { (response) in
            do{

                let eventsResponse = try JSONDecoder().decode(EventsModel.self, from: response.data!)
                self.arrayEvents = eventsResponse.events!
                    completion(eventsResponse)
            }catch{
                print("error")
            }
        }
    }

}
extension UpCommingTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayEvents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcommingcell", for: indexPath) as! UpCommingCollectionViewCell
        cell.eventLable.text=arrayEvents[indexPath.row].strEvent
        cell.dateLable.text=arrayEvents[indexPath.row].dateEvent
        cell.timeLable.text=arrayEvents[indexPath.row].strTimeLocal
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:
        IndexPath) -> CGSize {
        
        
        return CGSize(width: 300, height:150)
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    
        return 10
    }
        
    
}
