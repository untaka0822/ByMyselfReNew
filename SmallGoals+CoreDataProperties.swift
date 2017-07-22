//
//  SmallGoals+CoreDataProperties.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/07/19.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import Foundation
import CoreData


extension SmallGoals {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SmallGoals> {
        return NSFetchRequest<SmallGoals>(entityName: "SmallGoals")
    }

    @NSManaged public var memos: String?
    @NSManaged public var saveDate: NSDate?
    @NSManaged public var times: NSDate?
    @NSManaged public var titles: String?

}
