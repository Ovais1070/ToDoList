//
//  SaveListModel.swift
//  TodoApplication
//
//  Created by Ovais Naveed on 4/17/21.
//

import Foundation


class SaveListModel : NSObject ,NSCoding{
        var listName: String = ""
        var listId: String = ""
        
    
        override init() {
        
    }
    

    required public init(coder aDecoder: NSCoder) {
        self.listName = aDecoder.decodeObject(forKey: "listName") as? String ?? ""
        self.listId = aDecoder.decodeObject(forKey: "listId") as? String ?? ""
    
    
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(listName, forKey: "listName")
        aCoder.encode(listId, forKey: "listId")
   
   
    }
    
    init(listName: String, listId: String) {
        self.listName = listName
        self.listId = listId
       
    }

}









//class SaveListModel : NSObject ,NSCoding{
//        var listName: String = ""
//        var taskModel: [SaveTaskModel]?
//
//
//        override init() {
//
//    }
//
//
//    required public init(coder aDecoder: NSCoder) {
//        self.listName = aDecoder.decodeObject(forKey: "listName") as? String ?? ""
//        self.taskModel = aDecoder.decodeObject(forKey: "taskModel") as? [SaveTaskModel]
//
//
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(listName, forKey: "listName")
//        aCoder.encode(self.taskModel, forKey: "taskModel")
//
//
//    }
//
//    init(listName: String, taskModel: [SaveTaskModel]) {
//        self.listName = listName
//        self.taskModel = taskModel
//
//    }
//
//}
