//
//  SportsModel.swift
//  FinalProject
//
//  Created by Mariam Ayman on 3/23/21.
//

import Foundation
struct Sport:Codable {
    var sports:[SportInfo]?
    
}
struct SportInfo : Codable{
    
    var idSport:String?
    var strSport:String?
    var strFormat :StrFormat
    var strSportThumb: String?
    var strSportThumbGreen: String?
    var strSportDescription : String?
    
    

}
enum StrFormat: String, Codable {
    case eventSport = "EventSport"
    case teamvsTeam = "TeamvsTeam"
}
