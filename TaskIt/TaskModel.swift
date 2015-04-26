//
//  TaskModel.swift
//  TaskIt
//
//  Created by Sami on 02/04/15.
//  Copyright (c) 2015 Sami Paju. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel)
class TaskModel: NSManagedObject {

    @NSManaged var completed: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var subtask: String
    @NSManaged var task: String

}
