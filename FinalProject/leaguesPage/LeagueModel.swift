
//  LeagueModel.swift
//  FinalProject
//
//  Created by Mariam Ayman on 3/24/21.


import Foundation

// MARK: - Welcome
struct LeagueBase: Codable {
    let leagues: [League]
}

// MARK: - League
struct League: Codable {
    let idLeague, strLeague: String
    let strSport: StrSport
}

enum StrSport: String, Codable {
    case americanFootball = "American Football"
    case australianFootball = "Australian Football"
    case baseball = "Baseball"
    case basketball = "Basketball"
    case cricket = "Cricket"
    case cycling = "Cycling"
    case darts = "Darts"
    case eSports = "ESports"
    case esports = "Esports"
    case fieldHockey = "Field Hockey"
    case fighting = "Fighting"
    case golf = "Golf"
    case handball = "Handball"
    case iceHockey = "Ice Hockey"
    case motorsport = "Motorsport"
    case motorsports = "Motorsports"
    case netball = "Netball"
    case rugby = "Rugby"
    case snooker = "Snooker"
    case soccer = "Soccer"
    case tennis = "Tennis"
    case volleyball = "Volleyball"
}
