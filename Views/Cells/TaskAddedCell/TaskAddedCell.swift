//
//  TaskAddedCell.swift
//  TodoApplication
//
//  Created by Ovais Naveed on 4/17/21.
//

import UIKit

class TaskAddedCell: UITableViewCell {

    
    
    @IBOutlet weak var vu_bg: UIView!
    @IBOutlet weak var taskCompleteBtn: UIButton!
    @IBOutlet weak var taskTitle: UILabel!
    @IBOutlet weak var alarmImage: UIImageView!
    @IBOutlet weak var importantBtn: UIButton!
    
    var completionSelected = false
    var importantSelected = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vu_bg.layer.cornerRadius = 10
        taskCompleteBtn.isSelected = completionSelected
        importantBtn.isSelected = importantSelected
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func taskCompleteBtn(_ sender: Any) {
        if completionSelected == false {
            completionSelected = true
            taskCompleteBtn.isSelected = true
            print("taskCompleteBtn is selected")
        } else {
            completionSelected = false
            taskCompleteBtn.isSelected = false
            print("completionSelected is not selected")
        }
    }
    
    @IBAction func importantBtn(_ sender: Any) {
        if importantSelected == false {
            importantSelected = true
            importantBtn.isSelected = true
            print("importantSelected is selected")
        } else {
            importantSelected = false
            importantBtn.isSelected = false
            print("importantSelected is not selected")
        }
    }
    
}
