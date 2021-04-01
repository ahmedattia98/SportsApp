//
//  FavoriteLeague+CoreDataProperties.swift
//  
//
//  Created by Ahmed attia on 3/30/21.
//
//

import Foundation
import CoreData


extension FavoriteLeague {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteLeague> {
        return NSFetchRequest<FavoriteLeague>(entityName: "FavoriteLeague")
    }

    @NSManaged public var youtubeURL: String?
    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var badgeURL: String?

}
