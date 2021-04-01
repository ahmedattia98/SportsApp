//
//  EventModel.swift
//  FinalProject
//
//  Created by Ahmed attia on 3/28/21.
//

import Foundation
struct EventsModel:Codable {
   var events:[EventsInfo]?
}
struct EventsInfo:Codable{
    var idEvent:String?
    var strEvent:String?
    var strHomeTeam:String?
    var strAwayTeam:String?
    var intHomeScore: String?
    var intAwayScore: String?
    var dateEvent : String?
    var strTimeLocal:String?

}
enum CodingKeys: String, Codable {
    case idEvent = "idEvent"
    case strEvent = "strEvent"
    case strHomeTeam = "strHomeTeam"
    case strAwayTeam = "strAwayTeam"
    case intHomeScore = "intHomeScore"
    case intAwayScore = "intAwayScore"
    case dateEvent = "dateEvent"
}
