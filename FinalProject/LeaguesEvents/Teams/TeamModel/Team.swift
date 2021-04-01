//
//  Team.swift
//  FinalProject
//
//  Created by Mariam Ayman on 3/27/21.
//

import Foundation
struct TeamsModel:Codable {
   var teams:[TeamsInfo]?
}
struct TeamsInfo:Codable{
    var idLeague:String?
    var idTeam:String?
    var strTeam:String?
    var strTeamBadge:String?
    var strTeamJersey:String?
    var strStadiumThumb:String?
    var strStadium:String?
    var strCountry:String?
    var intFormedYear:String?
    var strYoutube:String?
    var strFacebook:String?
    var strWebsite:String?
    //var str : CodingKeysTeams
}
enum CodingKeysTeams: String, Codable {
    case idTeam = "idTeam"
    case idLeague = "idLeague"
    case strTeam = "strTeam"
    case strTeamBadge = "strTeamBadge"
    case strTeamJersey = "strTeamJersey"
    case strStadiumThumb = "strStadiumThumb"
    case strStadium = "strStadium"
    case strCountry = "strCountry"
    case intFormedYear = "intFormedYear"
    case strYoutube = "strYoutube"
    case strFacebook = "strFacebook"
    case strWebsite = "strWebsite"
    
}
