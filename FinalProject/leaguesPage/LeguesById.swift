//
//  LeguesById.swift
//  FinalProject
//
//  Created by Mariam Ayman on 3/25/21.
//

import Foundation
struct leguesOfId: Codable {
    let leagues: [LeagOfID]
}

// MARK: - League
struct LeagOfID: Codable {
        var id : String?
        var title : String?
        var country : String?
        var badge : String?
        var leagueYoutube : String?
    
        
        enum CodingKeys: String, CodingKey {
            case id = "idLeague"
            case title = "strLeague"
            case country = "strCountry"
            case  badge = "strBadge"
            case leagueYoutube = "strYoutube"
    //        case banner = "strBanner"
        }
        
}

