//
//  BigGoal+CoreDataProperties.swift
//  ByMyself
//
//  Created by untaka0822 on 2017/07/15.
//  Copyright © 2017年 untaka0822. All rights reserved.
//

import Foundation
import CoreData


extension BigGoal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BigGoal> {
        return NSFetchRequest<BigGoal>(entityName: "BigGoal")
    }

    @NSManaged public var title: String?
    @NSManaged public var time: Date?
    @NSManaged public var saveDate: NSDate?

}
