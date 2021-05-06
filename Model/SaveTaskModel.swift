//
//  SaveTaskModel.swift
//  TodoApplication
//
//  Created by Ovais Naveed on 4/17/21.
//

import Foundation

class SaveTaskModel : NSObject ,NSCoding{
        var taskName: String = ""
        var timeandDate: String = ""
        var listId: String = ""
        var taskId: String = ""
        
    
        override init() {
        
    }
    

    required public init(coder aDecoder: NSCoder) {
        self.taskName = aDecoder.decodeObject(forKey: "taskName") as? String ?? ""
        self.timeandDate = aDecoder.decodeObject(forKey: "timeandDate") as? String ?? ""
        self.listId = aDecoder.decodeObject(forKey: "listId") as? String ?? ""
        self.taskId = aDecoder.decodeObject(forKey: "taskId") as? String ?? ""
    
    
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(taskName, forKey: "taskName")
        aCoder.encode(timeandDate, forKey: "timeandDate")
        aCoder.encode(listId, forKey: "listId")
        aCoder.encode(taskId, forKey: "taskId")
   
   
    }
    
    init(taskName: String, timeandDate: String, listId: String, taskId: String) {
        self.taskName = taskName
        self.timeandDate = timeandDate
        self.listId = listId
        self.taskId = taskId
    }

}
